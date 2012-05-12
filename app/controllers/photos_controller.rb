class PhotosController < ApplicationController
  def index
    @page = Page.find_by_slug('photos')
    puts @page.inspect
  end
  
  def destroy
    
  end
end
