class HomeController < ApplicationController
  layout 'landing'
  def index
    #@page = Page.find_by_slug('home') || Page.first(:conditions => {:root => true})
    #render '/pages/show'
    
    cookies[:first_time_visit] = nil
    
    if cookies[:first_time_visit]
      redirect_to courses_path
      return
    else
      cookies[:first_time_visit] = {:value => Time.now.to_s, :expires => 1.year.from_now }
    end
  end
  
  def stage
    @page = Page.find_by_slug(params[:slug])
  end
  
  def zh
    I18n.locale = 'zh'
    session[:locale] = 'zh'
    redirect_to :back
  end
  
  def en
    I18n.locale = 'en'
    session[:locale] = 'en'
    redirect_to :back
  end
end
