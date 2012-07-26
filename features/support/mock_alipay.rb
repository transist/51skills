module AlipayMock
  extend WebMock::API

  # Mock requests send to Alipay and redirect back to return_url
  stub_request(:get, %r{https://www.alipay.com/cooperate/gateway.do.*}).
    to_return(
      status: 302,
      headers: lambda {|request|
        return_url = Rack::Utils.parse_nested_query(request.uri.query)['return_url']
        { Location: return_url }
      }
  )
end
