# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    login = params[:user][:login]
    if User.where(email: login).any? || User.where(phone_number: login).any?
      u = (User.where(email: login).first || User.where(phone_number: login).first)

      if u.valid_password?(params[:user][:password])
        self.resource = u
        # self.resource = warden.authenticate!(auth_options)
        set_flash_message!(:success, :signed_in)
        if resource.confirmed?
          @user = resource
          @user.update(is_online: true)
          sign_in(resource_name, resource)
          yield resource if block_given?
          respond_with resource, location: after_sign_in_path_for(resource)
        else
          flash[:danger] = t('devise.failure.unconfirmed')
          render :new
        end
      else
        flash[:danger] = "Wrong password, please try again"
        render :new
      end
    else
      flash[:danger] = "Email or phone number not found"
      render :new
    end
  end

  # DELETE /resource/sign_out
  def destroy
    current_user.update(is_online: false)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :success, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
