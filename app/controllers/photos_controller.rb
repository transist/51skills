class PhotosController < ApplicationController
  def index
    @page = Page.find_by_slug('photos')
  end
  
  def destroy
    
  end
end
