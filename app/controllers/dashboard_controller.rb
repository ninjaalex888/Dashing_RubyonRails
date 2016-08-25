class DashboardController < ApplicationController
	before_action :verify_github_permission
	caches_page :show, :show_dashboards, :list

	layout 'configLayout'

	def list
		@dashboards = Dashboard.all
	end

	def show
		@dashboard = Dashboard.find(params[:id])
	end

	def new
		@dashboards = Dashboard.all
	end

	def dashboard_params
		params.require(:dashboards).permit(:user_id, :pub, :release, :layoutDash?)
	end

	def create
		@dashboard = Dashboard.new(dashboard_param)
		@dashboard.user_id=User.find_by_token(session[:token]).id
		if @dashboard.save
			redirect_to :action => 'list'
		else
			@dashboards = Dashboard.all
			render :action => 'new'
		end
	end

	def edit
		@dashboard = Dashboard.find(params[:id])
		@dashboards = Dashboard.all
	end

	def dashboard_param
		params.require(:dashboard).permit(:user_id, :pub, :release, :layoutDash)
	end

	def update
		@dashboard = Dashboard.find(params[:id])

		if @dashboard.update_attributes(dashboard_param)
			redirect_to :action => 'show', :id => @dashboard
		else
			@dashboards = Dashboard.all
			render :action => 'edit'
		end
	end

	def delete
		Dashboard.find(params[:id]).destroy
		redirect_to :action => 'list'
	end

	def show_dashboards
		@dashboard = Dashboard.find(params[:id])
	end

	def verify_github_permission
	    client = Octokit::Client.new(:client_id => ENV['GITHUB_CLIENT_ID'], :client_secret => ENV['GITHUB_CLIENT_SECRET'])
	    client.check_application_authorization(session[:token])
	end

end
