class SessionsController < ApplicationController
  
  def new    
    redirect_to "/auth/#{params[:provider]}"
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth['info'] && !auth['info']['email'].blank? && Person.unique_email(auth['info']['email'])
      redirect_to root_url, :alert => 'The Email Address is Already in Used, Maybe you should sign in with your another account.' 
      return
    end
    provider = params[:provider]
    user = Person.where(:provider => provider, 
                        :uid => auth['extra']['raw_info']['id'].to_s).first || Person.create_with_omniauth(auth)
    session[:user_id] = user.id
    if !user.email || user.email == ''
      redirect_to edit_person_path(user), :alert => "Please enter your email address."
    else
      redirect_to :back, :notice => 'Signed in!'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
