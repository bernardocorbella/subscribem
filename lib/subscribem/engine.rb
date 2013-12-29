require "warden"
require "dynamic_form"

module Subscribem
  class Engine < ::Rails::Engine
    initializer "subscribem.middleware.warden" do
      Rails.application.config.middleware.use Warden::Manager do |manager|
        manager.default_strategies :password
      end
    end

    isolate_namespace Subscribem

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
  end
end
