class SessionsController < ApplicationController
  
  def new
    if params[:provider].to_s == 'facebook'
      facebook_url = Koala::Facebook::OAuth.new.url_for_oauth_code(:callback => "http://" + request.host_with_port + '/auth/facebook/callback')
      logger.info "*" * 80 + "facebook_url"
      logger.info facebook_url
      logger.info "http://" + request.host_with_port + '/auth/facebook/callback'
      redirect_to facebook_url
    else
      redirect_to "/auth/#{params[:provider]}"
    end
  
  end

  def create
    auth = request.env["omniauth.auth"]
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
    redirect_to :back, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
  
  def create_with_facebook
    logger.info "*" * 80 + "create with facebook"
    oauth_access_token = Koala::Facebook::OAuth.new("http://" + request.host_with_port + '/auth/facebook/callback').get_access_token(params[:code]) if params[:code]
    logger.info oauth_access_token
    profile = Koala::Facebook::API.new(oauth_access_token).profile
    logger.info params
    logger.info profile
  end
end
