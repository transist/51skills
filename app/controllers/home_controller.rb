class HomeController < ApplicationController
  def index
    @page = Page.first(:conditions => {:root => true})
    render '/pages/show'
  end
  
  def zh
    I18n.locale = 'zh'
    redirect_to :back
  end
  
  def en
    I18n.locale = 'en'
    redirect_to :back
  end
end
