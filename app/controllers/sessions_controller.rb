class SessionsController < ApplicationController
  
  def new    
    redirect_to "/auth/#{params[:provider]}"
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth['info'] && !auth['info']['email'].blank? && Person.unique_email(auth['info']['email'])
      redirect_to root_url, :alert => "#{auth['info']['email']} : #{I18n.t('alert.email_used')}"
      return
    end
    provider = params[:provider]
    user = Person.where(:provider => provider, 
                        :uid => auth['extra']['raw_info']['id'].to_s).first || Person.create_with_omniauth(auth)
    session[:user_id] = user.id
    if !user.email || user.email == ''
      redirect_to edit_person_path(user), :alert => I18n.t('alert.email_required')
    else
      redirect_to :back, :notice => I18n.t('notice.sign_in')
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => I18n.t('notice.sign_out')
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}. Please try to sign in with other account or contact simsicon#gmail.com"
  end

end
