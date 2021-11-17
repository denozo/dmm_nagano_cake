# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # def reject_user
  #   @customer = customer.find_by(name: [])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

    #退会会員はログインできないように制御
    def after_sign_in_path_for(recource)
      if resource.is_active == "withdraw"
        sign_out recource
        root_path
      else
        items_path
      end
    end

end
