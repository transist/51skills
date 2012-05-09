class PeopleController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def index
    @users = Person.paginate(:page => params[:page])
  end

  def edit
    if current_user.id == params[:id] || current_user.admin?
      @page = create_standard_page
      @user = Person.find(params[:id])
    end
  end

  def update
    @user = Person.find(params[:id])
    if @user.update_attributes(params[:person])
      redirect_to @user
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
