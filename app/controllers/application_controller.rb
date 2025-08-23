class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      public_mypage_path
    elsif resource.is_a?(Admin)
      admin_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    public_homes_top_path
  end
end
