class PhotosController < ApplicationController
  def index
    @page = create_standard_page
  end
end
