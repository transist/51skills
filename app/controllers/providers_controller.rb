class ProvidersController < ApplicationController
  before_filter :correct_user_by_person_id!
  
  def new
    redirect_to "/auth/#{params[:provider]}"
  end
  
  def create
    
  end
  
  def destroy
    person = Person.find params[:person_id]
    if ( !person.email || person.email == '') && person.providers.count == 1
      redirect_to(edit_person_path(person.id), :alert => I18n.t('alert.your_action_might_lead_you_cant_login_anymore'))
      return
    end
    provider = Provider.find params[:id]
    provider.destroy
    redirect_to edit_person_path(person.id)
  end
end
