class CourseSessionsController < ApplicationController
  before_filter :find_course, :only => ['index', 'create']
  before_filter :authenticate_user!
  
  def index
    @page  = Page.find_by_slug('courses')
    @course_sessions = @course.course_sessions
    @course_session = CourseSession.new
  end
  
  def create
    course_session = CourseSession.create(params[:course_session])
    @course.course_sessions << course_session
    redirect_to course_course_sessions_path(@course.id)
  end
  
  protected
  def find_course
    @course = Course.find_by_id(params[:course_id])
  end
end
