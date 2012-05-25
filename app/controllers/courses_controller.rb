class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @page  = Page.find_by_slug('courses')
  end

  def new
    @course = Course.new
  end
  
  def search
    session[:query] = params[:search][:q]
    session[:query_params] = params[:search][:q].split(' ').join("+")
    @page  = Page.find_by_slug('search')
    redirect_to '/search/' + URI.escape(session[:query_params])
  end
  
  def results
    if session[:query_params] == params[:q]
      @courses = Course.search(session[:query])
    else
      @courses = Course.search(params[:q].split('+').join(' '))
    end
    session[:query] = nil
    session[:query_params] = nil
    logger.info(@courses.inspect)

    @page  = Page.find_by_slug('search')
    render 'courses/search'
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
