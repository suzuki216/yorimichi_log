class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_active, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when User
      public_mypage_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      public_homes_top_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def check_active
    if current_user && !current_user.is_active
      reset_session
      redirect_to root_path, alert: "退会済みのアカウントです。"
    end
  end
end
