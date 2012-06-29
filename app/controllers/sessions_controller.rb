class SessionsController < ApplicationController
  
  def new    
    redirect_to "/auth/#{params[:provider]}"
  end

  def create
    auth = request.env["omniauth.auth"]
    provider_name = params[:provider]
    provider = Provider.find_by_provider_and_uid(provider_name, auth['extra']['raw_info']['id'].to_s)
    person = nil
    if provider
      if current_user
        redirect_to edit_person_path(current_user.id), :alert => I18n.t('alert.provider_in_used')
        return
      else
        person =  provider.person
        sign_in person
      end
    else
      if current_user
        provider = Provider.create_provider_with_omniauth(auth)
        current_user.providers << provider
        person = current_user
        redirect_to edit_person_path(current_user.id), :notice => I18n.t('notice.connected')
        return
      else
        person = Person.create_with_omniauth(auth)
        sign_in person
      end
    end

    if !person.email || person.email == ''
      redirect_to edit_person_path(person), :alert => I18n.t('alert.email_required')
    else
      redirect_to courses_path, :notice => I18n.t('notice.sign_in')
    end
  end
  
  def change_password
    reset_session
    redirect_to new_person_password_path
  end

  def destroy
    reset_session
    redirect_to courses_path, :notice => I18n.t('notice.sign_out')
  end

  def failure
    redirect_to courses_path, :alert => "Authentication error: #{params[:message].humanize}. Please try to sign in with other account or contact simsicon#gmail.com"
  end

end
