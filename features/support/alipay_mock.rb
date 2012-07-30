class AlipayMock
  include WebMock::API

  # Mock requests send to Alipay, notify the notify_url with mock data,
  # and then redirect back to return_url.
  def self.stub!
    self.new.stub!
  end

  def stub!
    stub_request(:get, %r{https://www.alipay.com/cooperate/gateway.do.*}).
      to_return(
        status: 302,
        headers: lambda {|request|

          params = Hashie::Mash.new(Rack::Utils.parse_query(request.uri.query))

          Capybara.page.driver.post(params.notify_url, sign!(notify_data(params)))

          { Location: params.return_url }
        }
    )
  end

  private
  def sign!(params)
    raw_query_string = params.sort.map {|key, value| "#{key}=#{CGI.unescape(value)}" }.join("&")
    sign = Digest::MD5.hexdigest(raw_query_string + ActiveMerchant::Billing::Integrations::Alipay::KEY)
    params['sign'] = sign
    params['sign_type'] = 'MD5'
    params
  end

  def notify_data(params)
    notify_data = {
      "discount" => "0.00",
      "payment_type" => "1",
      "subject" => params.subject,
      "trade_no" => "2012072750852687",
      "buyer_email" => "simsicon@gmail.com",
      "gmt_create" => "2012-07-27 14:59:47",
      "notify_type" => "trade_status_sync",
      "quantity" => "1",
      "out_trade_no" => params.out_trade_no,
      "seller_id" => "2088701947399296",
      "notify_time" => "2012-07-27 16:24:00",
      "body" => params.body,
      "trade_status" => "TRADE_SUCCESS",
      "is_total_fee_adjust" => "N",
      "total_fee" => params.total_fee,
      "gmt_payment" => "2012-07-27 15:00:01",
      "seller_email" => params.seller_email,
      "price" => "0.42",
      "buyer_id" => "2088002272728875",
      "notify_id" => "af882e0e6610b7a59ef333b469f6f60008",
      "use_coupon" => "N"
    }
  end
end
