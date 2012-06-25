if ENV['RAILS_ENV'].to_s == 'production'
  HireFire.configure do |config|
    config.environment      = :heroku # default in production is :heroku. default in development is :noop
    config.max_workers      = 5   # default is 1
    config.min_workers      = 0   # default is 0
    config.job_worker_ratio = [
        { :jobs => 0,   :workers => 0 },
        { :jobs => 1,   :workers => 1 },
        { :jobs => 15,  :workers => 2 },
        { :jobs => 35,  :workers => 3 },
        { :jobs => 60,  :workers => 4 },
        { :jobs => 80,  :workers => 5 }
      ]
  end

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
end
