class ApplicationController < ActionController::Base
	include ApplicationHelper
  include Pagy::Backend
	
  add_flash_types :success, :info, :warning, :danger

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, if: :page_not_free?
	protected
  def configure_permitted_parameters
    # Permit the `subscribe_newsletter` parameter along with the other
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :phone_number])
  end
end
