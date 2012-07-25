class EnrollmentsController < ApplicationController
  include PayFu::AlipayHelper

  before_filter :load_enrollment

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
      return_url: paid_enrollment_path(@enrollment)
    )
  end

  def pay_via_paypal
  end
end
