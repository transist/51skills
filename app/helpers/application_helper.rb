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

  def watch_btn(course, location)
    watch = I18n.t('watch')
    unwatch = I18n.t('unwatch')
    watch_or_unwatch = current_user ? (current_user.watching_courses.include?(course) ? unwatch : watch) : watch
    if location == 'show'
      link_to "<i class='icon-eye-open'></i><span class='watch'>#{watch_or_unwatch}</span>".html_safe,
              course_watch_path(course.id), :class => 'btn btn-large watch_btn', :method => 'post'
    elsif location == 'list'
      link_to "<i class='icon-eye-open'></i><span class='watch'>#{watch_or_unwatch}</span>".html_safe,
              course_watch_path(course.id), :class => 'btn btn-mini watch_btn', :method => 'post'
    end
  end

  def enrollment_btn
    if not @enrollment
      # Enroll button
      icon_class = @course.free? ? 'icon-ok-sign' : 'icon-shopping-cart'
      icon_class << ' icon-white'
      enroll_button = content_tag(:i, nil, class: icon_class)
      enroll_button << content_tag(:span, class: 'enroll') do
        t :enroll
      end
      link_to enroll_button, course_enroll_path(@course.id),
        class: 'btn btn-large btn-success enroll_btn', method: 'post'

    elsif not @course.free? and @enrollment.unpaid?
      # Pay button and Cancel button
      content_tag(:div, nil, class: 'btn-group') do
        pay_button = content_tag(:i, nil, class: 'icon-shopping-cart icon-white') +
          t('enrollments.my_enrollments.pay')
        link_to(pay_button, confirm_enrollment_path(@enrollment),
          class: 'btn btn-large btn-info', method: :get) +
        link_to(t('enrollments.my_enrollments.cancel'), cancel_enrollment_path(@enrollment),
          class: 'btn btn-large', method: :delete)
      end

    elsif not @course.free? and @enrollment.paid?
      # Paid status
      content_tag(:span, class: 'label label-success paid') do
        t 'courses.show.paid'
      end

    elsif @course.free? and @enrollment.paid?
      # Disenroll button
      disenroll_button = content_tag(:i, nil, class: 'icon-remove-sign icon-white')
      disenroll_button << content_tag(:span, class: 'enroll') do
        t :disenroll
      end
      link_to disenroll_button, course_disenroll_path(@course.id),
        class: 'btn btn-large btn-success enroll_btn', method: 'post'
    end
  end

  def price_helper(course)
    label = course.free? ? t('courses.show.free') : number_to_currency(course.price, locale: :zh)
    content_tag :span, class: 'label label-info price' do
      label
    end
  end

  def watchers_badge(course)
    count = course.watchers.count
    notice = count > 1 ? "#{count} #{I18n.t('people_are_watching_this_course')}" : (count == 1 ? "#{count} #{I18n.t('person_is_watching_this_course')}" : "")
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

  def notice_helper
    if notice
      content_tag :div, :class => 'alert alert-success' do
        s = content_tag 'button', :class => 'close', :data => {:dismiss => 'alert'} do
          "x"
        end
        s = s + notice
        s
      end
    end
  end

  def alert_helper
    if alert
      content_tag :div, :class => 'alert alert-error' do
        s = content_tag 'button', :class => 'close', :data => {:dismiss => 'alert'} do
          "x"
        end
        s = s + alert
        s
      end
    end
  end

  def watchers_name_helper
    @course.watchers.limit(5).map {|watcher| watcher.name}.join(", ")
  end

  def connect_social_botton(provider_name)
    including = @user.providers.map{|p| p.provider}.include?(provider_name.to_s)
    connect = including ? 'disconnect' : 'connect'
    method = including ? :delete : :get
    provider = Provider.find_by_provider_and_person_id(provider_name, @user.id)
    url = including ? person_provider_path(@user.id, provider.id) : new_person_provider_path(@user.id).to_s + "?provider=#{provider_name}"
    link_to connect, url, :class => 'btn btn-min social_botton', :method => method
  end

end
