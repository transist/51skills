# encoding: UTF-8
module ApplicationHelper
  def editor_path(path)
    "/editor/#{path}"
  end
  
  def chosen_single_select(choices, options={})
    helper_options = {:class => 'chzn-select chosen_single_select', :tabindex => '7'}
    helper_options.merge(options) do |key, oldval, newval|
      newval = oldval + ' ' + newval
      helper_options.merge!({key => newval})
    end
    select("category", "category_id", choices, { :include_blank => true }, helper_options)
  end
  
  def current_category?(category)
    @category && (category.id == @category.id)
  end
  
  def watch_btn(course)
    watch = current_user ? (current_user.watching_courses.include?(course) ? 'unwatch' : 'watch') : 'watch'
    link_to "<i class='icon-eye-open'></i><span class='watch'>#{watch}</span>".html_safe, course_watch_path(course.id), :class => 'btn btn-mini watch_btn', :method => 'post'
  end
  
  def watchers_badge(course)
    count = course.watchers.count
    notice = count > 1 ? "#{count} people are watching this course." : (count == 1 ? "#{count} person is watching this course." : "")
    content_tag :span, :class => "badge badge-watchers" do
      notice
    end unless notice.empty?
  end
  
  def zh_or_en_link
    if I18n.locale == :en
      link_to '中文', '/zh'
    else
      link_to 'English', '/en'
    end
  end
end
