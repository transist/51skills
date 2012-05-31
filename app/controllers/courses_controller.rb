class CoursesController < ApplicationController
  before_filter :yield_page
  before_filter :authenticate_user!, :except => ['index', 'show', 'search', 'results']
  
  def yield_page
    @page  = Page.find_by_slug('courses')
  end
  
  def index
    @courses = collection
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
    @course = Course.find params[:id]
    @course.update_attributes(params[:course])
    @course = @course.save_category(params[:sub_category])
    redirect_to course_path(@course.id)
  end
  
  def create
    @course = Course.create(params[:course])
    @course = @course.save_category(params[:sub_category])
    redirect_to courses_path
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end
  
  def show
    
  end
  
  def watch
    @course = Course.find params[:course_id]
    if current_user.watching_courses.include?(@course)
      watch = Watch.find_by_course_id_and_person_id(@course.id, current_user.id)
      watch.destroy
    else
      @course.watchers << current_user
    end
    redirect_to :back
  end
  
  protected
    def collection
      Course.paginate(:page => params[:page], :per_page => 12)
    end
  

end
