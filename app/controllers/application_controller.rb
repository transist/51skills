class ApplicationController < ActionController::Base
  include Mercury::Authentication
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :is_editing?
  layout :layout_with_mercury


  private

  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end

  def is_editing?
    cookies[:editing] == 'true' && can_edit?
  end

  def is_editing?
    cookies[:editing] == 'true' && can_edit?
  end

  def current_user
    begin
      @current_user ||= Person.find(session[:user_id]) if session[:user_id]
    rescue 
      nil
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = Person.find(params[:id])
    unless current_user == @user
      redirect_to root_url, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => 'You need to sign in for access to this page.'
    end
  end
end
