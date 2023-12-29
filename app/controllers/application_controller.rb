class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # helper_method :current_user, :logged_in?

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def logged_in?
  #   !!current_user
  # end

  # def require_user
  #   if !logged_in?
  #     flash[:alert] = "You must be logged in to perform that action"
  #     # redirect_to login_path
  #     redirect_to user_session_path

  #   end
  # end

  # 
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    flash[:alert] = "Access denied. #{exception.message}"
    redirect_to root_path 
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :user_type])
  end

end
