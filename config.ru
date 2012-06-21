# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Tedx::Application

require 'resque/server'
run Rack::URLMap.new \
  "/resque" => Resque::Server.new