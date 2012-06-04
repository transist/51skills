class PeopleController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?
  before_filter :yield_page, :only => ['index', 'edit', 'update', 'show']
  
  def yield_page
    @page = create_standard_page
  end

  def index
    @users = Person.paginate(:page => params[:page])
  end

  def edit
    if current_user.id == params[:id] || current_user.admin?
      @user = Person.find(params[:id])
    end  
  end

  def update
    @user = Person.find(params[:id])
    if @user.update_attributes(params[:person]) 
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    if current_user.admin?
      @user = Person.find(params[:id])
    end
  end
end
