class ApplicationController < ActionController::Base
  include Mercury::Authentication
  protect_from_forgery
  before_filter :accepted_languages
  before_filter :set_language
  before_filter :email_address_complete!
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :is_editing?
  helper_method :current_user_admin?
  helper_method :email_address_complete?
  layout :layout_with_mercury
  

  private
  def after_sign_in_path_for(resource)
    courses_path
  end
  
  def after_sign_out_path_for(resource)
    courses_path
  end
  
  def layout_with_mercury
    !params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
  end

  def is_editing?
    cookies[:editing] == 'true' && can_edit?
  end

  def is_editing?
    cookies[:editing] == 'true' && can_edit?
  end
  
  def email_address_complete?
    !current_user || (current_user && !current_user.email.blank?)
  end
  
  def email_address_complete!
    unless email_address_complete?
      redirect_to(edit_person_path(current_user.id), :alert => I18n.t('alert.email_completed')) 
    end
  end

  def current_user
    begin
      @current_user ||= Person.find(session[:user_id]) if session[:user_id]
    rescue 
      nil
    end
  end
  
  def current_user_admin?
    current_user && current_user.admin?
  end
  
  def current_user_admin!
    unless current_user_admin?
      redirect_to courses_path, :alert => I18n.t('alert.admin_only')
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = Person.find(params[:id])
    unless current_user == @user
      redirect_to courses_path, :alert => I18n.t('alert.access_denied')
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to :back, :alert => I18n.t('alert.sign_in_required')
    end
  end
  
  def accepted_languages
    return [] if request.env["HTTP_ACCEPT_LANGUAGE"].nil?
    accepted = request.env["HTTP_ACCEPT_LANGUAGE"].split(",")
    accepted = accepted.map { |l| l.strip.split(";") }
    accepted = accepted.map { |l|
      if (l.size == 2)
        [ l[0].split("-")[0].downcase, l[1].sub(/^q=/, "").to_f ]
      else
        [ l[0].split("-")[0].downcase, 1.0 ]
      end
    }
    a = accepted.sort { |l1, l2| l1[1] <=> l2[1] }
    if session[:locale] == nil
      if a[0][0].include?('en') && 
        session[:locale] = 'en'
        I18n.locale = 'en'
      else
        session[:locale] = 'zh'
        I18n.locale = 'zh'
      end
    end
  end
  
  def set_language
    if params[:locale]
      session[:locale] = params[:locale]
    end
    if session[:locale] == nil
      session[:locale] = 'en' 
    end
    I18n.locale = session[:locale]
  end
  
  def create_standard_page
    @page = Hashie::Mash.new
    @page.title = '51skills'
    @page.header = true
    @page.sidebar = true
    @page
  end
  
end
