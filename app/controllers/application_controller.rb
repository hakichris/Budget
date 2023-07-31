class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Devise::Controllers::Helpers


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name password password_confirmation])
  end

  protected

  def after_sign_up_path_for(resource_or_scope)
    new_user_session_path
  end
end
