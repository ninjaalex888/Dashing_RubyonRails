	class SessionsController < ApplicationController
    before_action :reset_session
	skip_before_action :user_authorized?, only: [:authorization, :new, :create]

	def authorization
	end

	def new
		redirect_to '/auth/github'
	end

	def create
        @user =find_or_create_by_me(user_params)
		if access_permitted?
		  session[:token] = @user.token
		  session[:id]=@user.id
		  redirect_to root_path
		else
		  redirect_to "https://coupa-release.herokuapp.com/authorization", :flash => { :error => "You are not authorized for this application!" }
		end
		return
	end

	def find_or_create_by_me(params)
		if User.where(:uid=>params[:uid]).blank?
			@user=User.create(params)
			@user.save
			return @user
		end
		User.where(:uid=>params[:uid]).first.update_attributes(:token=>params[:token])
		return User.where(:uid=>params[:uid]).first
	end

	def destroy
		reset_session
		respond_to do |format|
		  format.html { redirect_to root_url }
		  format.js { render :js => "window.location.reload();" }
		end
	end

	private
		def access_permitted?
		begin
		  Coupa::PermissionsService.new(@user).call("is_coupa_user")
		rescue Octokit::Unauthorized
		  redirect_to "https://coupa-release.herokuapp.com/authorization"
		end
	end

	protected
	def auth_hash
		request.env['omniauth.auth']
	end

	def user_params
		transform(auth_hash).require(:user).permit(:uid, :name, :login, :token)
	end

	def transform(auth_hash)
		params=ActionController::Parameters.new(user:{uid: auth_hash[:uid],name:auth_hash[:info][:name],login: auth_hash[:info][:nickname],token: auth_hash[:credentials][:token]})
	end
end













