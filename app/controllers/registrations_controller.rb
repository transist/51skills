class RegistrationsController < Devise::RegistrationsController
  
  protected
  def after_sign_up_path_for(resource)
    session[:after_sign_up] = true
    courses_path
  end
end