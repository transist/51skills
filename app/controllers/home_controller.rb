class HomeController < ApplicationController
  def index
    @page = Page.first(:conditions => {:root => true})
    logger.info(":::::::::::::::#{I18n.locale}")
    # render '/pages/show'
    @page.sidebar = false
    logger.info(@page.sidebar)
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
