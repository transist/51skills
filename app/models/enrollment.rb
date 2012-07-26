# encoding: UTF-8
class Enrollment < ActiveRecord::Base
  include Enumerize

  PAYMENT_METHODS = [:alipay, :paypal].freeze
  STATES_TRANSLATIONS = {paid: '已支付', unpaid: '未支付'}.freeze

  attr_accessible :course_id, :person_id, :payment_method
  belongs_to :person
  belongs_to :course

  enumerize :payment_method, in: PAYMENT_METHODS, default: :alipay
  

  state_machine :state, initial: :unpaid do
    event :pay do
      transition unpaid: :paid
    end
  end

  def notify
    email = Email.build("Your enrollment has been confirmed!", 
                        self.person.email, "enrollment_confirmed", 
                        {:recipient_name => self.person.name, 
                         :course_name => self.course.name(I18n.locale), 
                         :address => self.course.address,
                         :start_date_time => self.course.start_date_time.strftime('%Y-%m-%e %H:%M:%S%p'),
                         :price => self.course.human_price}, true)
    Resque.enqueue(Email, email.id) if email.save
  end

  def payment_subject
    I18n.t :payment_subject, scope: :enrollment, course: course.name(I18n.locale)
  end

  def state_for(locale)
    case locale.to_sym
    when :zh
      STATES_TRANSLATIONS[self.state.to_sym]
    when :en
      self.state
    end
  end
end
