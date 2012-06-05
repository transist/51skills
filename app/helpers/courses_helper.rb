module CoursesHelper
  def course_admin_action(course)
    content_tag('div', :class => 'course_admin_actions') do
      edit_course_helper(course) + 
      delte_course_helper(course)
    end  
  end
  
  def edit_course_helper(course)
    link_to I18n.t('edit'), edit_course_path(course.id), :class => 'btn btn-mini action edit_course' if current_user_admin?
  end
  
  def delte_course_helper(course)
    link_to(I18n.t('delete'), course_path(course.id), :class => 'btn btn-mini btn-danger action delete_course', :method => 'delete', :confirm => 'Are you sure? It can not be recovered!!') if current_user_admin?
  end
end
