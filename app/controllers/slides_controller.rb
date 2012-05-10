class SlidesController < ApplicationController
  before_filter :populate_parents
  
  def index
    
  end
  
  def create
    
  end
  
  def destroy
    
  end
  
  def populate_parents
    @page = Page.find(params[:page_id])
  end
end
