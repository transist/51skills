class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @course = Course.find(params[:course_id])
    @comment = Comment.build_from(@course, current_user.id, params[:comment][:body] )
    @comment.save
    redirect_to course_path(@course.id)
  end
end
