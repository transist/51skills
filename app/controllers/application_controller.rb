class ApplicationController < ActionController::Base
  include Mercury::Authentication
  protect_from_forgery
  before_filter :accepted_languages
  before_filter :set_language
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
    if session[:locale] == nil || request.path == '/'
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
    @page.title = 'TedX Shanghai'
    @page.manual = true
    @page.header = true
    @page.sidebar = true
    @page
  end
end
