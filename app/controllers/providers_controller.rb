class ProvidersController < ApplicationController
  def new
    redirect_to "/auth/#{params[:provider]}"
  end
  
  def create
    
  end
  
  def destroy
    provider = Provider.find params[:id]
    provider.destroy
    redirect_to edit_person_path(params[:person_id])
  end
end
