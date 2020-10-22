class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :birthday, :location, :email, :password, :password_confirmation, :remember_me, :profile_picture, :profile_picture_cache) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :birthday, :location, :email, :password, :password_confirmation, :current_password, :profile_picture, :profile_picture_cache, :remove_profile_picture) }
  end
end
