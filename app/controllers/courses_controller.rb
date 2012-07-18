class CoursesController < ApplicationController
  before_filter :yield_page, :except => ['show']
  before_filter :authenticate_user!, :except => ['index', 'show', 'search', 'results']
  before_filter :current_user_admin!, :only => ['new', 'create', 'edit', 'update', 'delete', 'destroy']
  
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
      @courses = Course.search(session[:query]).paginate(:page => params[:page], :per_page => 12)
    else
      @courses = Course.search(params[:q].split('+').join(' ')).paginate(:page => params[:page], :per_page => 12)
    end
    session[:query] = nil
    session[:query_params] = nil
    render 'courses/index'
  end

  def edit
    @course = Course.find(params[:id])
  end

  def submit
    @course = Course.new
  end
  
  def update    
    @course = Course.find params[:id]
    @course.update_attributes(params[:course].merge({owner_id: current_user.id}))
    redirect_to @course
  end
  
  def create
    @course = Course.new(params[:course].merge({owner_id: current_user.id}))
    if @course.save
      redirect_to edit_course_path(@course), :notice => 'The course successfully created!'
    else
      render :new
    end
    
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end
  
  def show
    @course = Course.find(params[:id])
    @course.counting(1) unless current_user_admin?
    @person = Person.new
  end
  
  def watch
    @course = Course.find params[:course_id]
    if current_user.watching_courses.include?(@course)
      watch = Watch.find_by_course_id_and_person_id(@course.id, current_user.id)
      watch.destroy
      notice = 'You have unwatched the course successfully.'
    else
      @course.watchers << current_user
      notice = 'You have watched the course successfully.'
    end
    redirect_to :back, notice: notice
  end
  
  def enroll
    @course = Course.find params[:course_id]
    if current_user.enrolled_courses.include?(@course)
      enrollment = Enrollment.find_by_course_id_and_person_id(@course.id, current_user.id)
      enrollment.destroy
      notice = 'You have canceled the enrollment the course successfully.'
    else
      @course.students << current_user
      @course.enrollments.find{|enrollment| enrollment.person_id == current_user.id}.notify
      notice = 'You have enrolled the course successfully.'
    end
    redirect_to :back, notice: notice
  end
  
  def activate
    @course = Course.find params[:course_id]
    @course.activate
    redirect_to :back
  end
  
  def complete
    @course = Course.find params[:course_id]
    @course.complete
    redirect_to :back
  end
  
  def cancel
    @course = Course.find params[:course_id]
    @course.cancel
    redirect_to :back
  end
  
  def postpone
    @course = Course.find params[:course_id]
    @course.postpone
    redirect_to :back
  end
  
  protected
  def collection
    state = params[:state] || :active
    Course.where(:state => state).paginate(:page => params[:page], :per_page => 6, :order => 'start_date_time ASC')
  end
  

end
