class PeopleController < ApplicationController
  before_filter :authenticate_user!, :except => ['show']
  before_filter :correct_user?, :except => ['show']
  before_filter :yield_page, :only => ['index', 'edit', 'update', 'show']
  skip_before_filter :email_address_complete!, :only => [:edit, :update]
  
  def yield_page
    @page = create_standard_page
  end

  def index
    #@users = Person.paginate(:page => params[:page])
  end

  def edit
    @user = Person.find(params[:id])
  end

  def update
    @user = Person.find(params[:id])
    if @user.update_attributes(params[:person]) 
      redirect_to courses_path
    else
      render :edit
    end
  end

  def show
    @user = Person.find(params[:id])
  end
end
