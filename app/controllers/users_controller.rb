class UsersController < ApplicationController
	before_action :user_authorized?
	rescue_from Octokit::NotFound, with: :force_sign_out

  def lists
    @users=User.all
    render 'list'
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end

  def user_authorized?
    token = session[:token]
    if token.nil?
      redirect_to "https://coupa-release.herokuapp.com/authorization"
    # elsif User.find_by_token(session[:token]).nil?
    #   redirect_to "https://coupa-release.herokuapp.com/authorization" 
    else
      true
    end
  end

  protected
  def force_sign_out
    redirect_to "https://coupa-release.herokuapp.com/authorization"
  end

end