class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Devise::Controllers::Helpers


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name password password_confirmation])
  end

  protected

  def after_sign_up_path_for(resource)
    new_user_session_path
    puts "i am already here"
  end
end
