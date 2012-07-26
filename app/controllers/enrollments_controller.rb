class EnrollmentsController < ApplicationController
  include PayFu::AlipayHelper

  before_filter :load_enrollment, :only => [:confirm, :pay, :paid]

  def index
    load_sidebar_page
    @enrollments = current_user.enrollments
  end

  def confirm
  end

  def pay
    if @enrollment.update_attributes params[:enrollment]
      case @enrollment.payment_method.to_sym
      when :alipay
        pay_via_alipay
      when :paypal
        pay_via_paypal
      end
    else
      alert = 'Payment method not supported.'
      render action: :confirm
    end
  end

  def paid
    notice = 'You have enrolled the course successfully.'
    redirect_to @enrollment.course
  end

  def cancel
    current_user.disenroll(load_enrollment.course)
    notice = 'You have disenrolled the course successfully.'
    redirect_to :back, notice: notice
  end

  private
  def load_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  def pay_via_alipay
    redirect_to_alipay_gateway(
      subject: @enrollment.payment_subject,
      amount: @enrollment.course.price_in_cny.to_s,
      out_trade_no: @enrollment.id.to_s,
      notify_url: pay_fu.alipay_transactions_notify_url,
      return_url: paid_enrollment_url(@enrollment)
    )
  end

  def pay_via_paypal
  end

  def load_sidebar_page
    @page = Page.find_by_slug('enrollments')
  end
end
