class HomeController < ApplicationController
  layout 'landing'
  before_filter :email_address_format_validation, :only => ['subscribe']
  #before_filter :email_address_uniqueness_validation, :only => ['subscribe']
  
  def index
    #@page = Page.find_by_slug('home') || Page.first(:conditions => {:root => true})
    #render '/pages/show'
    if cookies[:first_time_visit]
      redirect_to courses_path
      return
    else
      cookies[:first_time_visit] = {:value => Time.now.to_s, :expires => 1.year.from_now }
      redirect_to '/landing'
    end
  end
  
  def landing
    render 'index'
  end
  
  def subscribe
    to_address = params[:email].to_s
    #email = Email.build("Almost Done", to_address, "subscribe_newsletter", {:name => 'simsicon'}, true)
    #Resque.enqueue(Email, email.id) if email.save
    #email.save
    MC_API.list_subscribe({:id => '3de230d695', :email_address => to_address, :merge_vars => {:GROUPINGS => [{:id => '7085'}]}})
    redirect_to courses_path, :notice => I18n.t('notice.check_your_inbox')
  end
  
  def subscribe_confirm
    code = params[:code].to_s
    email = Email.find_by_code(code)
    if email
      MC_API.list_subscribe({:id => '3de230d695', :email_address => email.to_address, :merge_vars => {:GROUPINGS => [{:id => '7085'}]}})
    end
    redirect_to courses_path, :notice => I18n.t('notice.thanks_confirmation')
  end
  
  def stage
    @page = Page.find_by_slug(params[:slug])
  end
  
  def zh
    I18n.locale = 'zh'
    session[:locale] = 'zh'
    redirect_to :back
  end
  
  def en
    I18n.locale = 'en'
    session[:locale] = 'en'
    redirect_to :back
  end
  
  protected
  
  def email_address_format_validation
    to_address = params[:email].to_s
    if to_address.empty?
      redirect_to('/landing#/subscript', :notice => I18n.t('alert.email_address_format_validation'))
    end
    
    if !(/^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i.match(to_address))
      redirect_to('/landing#/subscript', :notice => I18n.t('alert.email_address_format_validation'))
    end
  end
  
  def email_address_uniqueness_validation
    to_address = params[:email].to_s.downcase
    if Email.where(:to_address => to_address).count > 0
      redirect_to '/landing#/subscript', :notice => I18n.t('alert.email_already_in_used')
    end
  end
end
