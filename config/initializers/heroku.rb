class HireFire::Environment::Heroku
  
  private

  def workers(amount = nil)
    
    if amount.nil?
      # return client.info(ENV['APP_NAME'])[:workers].to_i
      return client.ps(ENV['APP_NAME']).select {|p| p['process'] =~ /worker.[0-9]+/}.length
    end

    # client.set_workers(ENV['APP_NAME'], amount)
    return client.ps_scale(ENV['APP_NAME'], {"type" => "worker", "qty" => amount})

  rescue RestClient::Exception
    HireFire::Logger.message("Worker query request failed with #{ $!.class.name } #{ $!.message }")
    nil
  end
end

# quick override to ensure that HireFire is activated on Heroku. The change is that it is looking for
# ::Rails.env.production? instead of ENV.include?('HEROKU_UPID')
module HireFire
  module Environment

    module ClassMethods
      
      def environment
        @environment ||= HireFire::Environment.const_get(
          if environment = HireFire.configuration.environment
            environment.to_s.camelize
          else
            ::Rails.env.production? ? 'Heroku' : 'Noop'
          end
        ).new
      end
      
    end
  end
end