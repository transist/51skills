class SlidesController < ApplicationController
  before_filter :populate_parents
  
  def index
    
  end
  
  def create
    logger.info(params[:slide])
    params[:slide].each do |slide|
      Slide.create(:image => slide, :presentation_id => @page.slideshow.id, :height => @page.slideshow.height, :width => @page.slideshow.width)
    end
    
    redirect_to edit_page_path(@page)
  end
  
  def destroy
    redirect_to edit_page_path(@page)
  end
  
  def populate_parents
    @page = Page.find_by_slug(params[:page_id])
  end
end
