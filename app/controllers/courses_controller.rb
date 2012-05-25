class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def submit
    @course = Course.new
  end
  
  def update
    @course = Course.find(params[:id])
    redirect_to :back
  end
  
  def create
    @course = Course.find(params[:id])
    redirect_to :back
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to :back
  end
end
