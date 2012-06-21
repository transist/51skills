class AdminController < ApplicationController
  before_filter :current_user_admin!
  
  def index
  end
end
