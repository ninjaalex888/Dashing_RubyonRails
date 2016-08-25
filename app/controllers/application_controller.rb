class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_action :user_authorized?

  rescue_from Octokit::NotFound, with: :force_sign_out

  private
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

  include ActionController::Caching::Pages
  self.page_cache_directory="#{Rails.root.to_s}/public/page_cache"
end
