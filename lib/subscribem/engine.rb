require "warden"
require "dynamic_form"
require "apartment"
require 'apartment/elevators/subdomain'

module Subscribem
  class Engine < ::Rails::Engine
    initializer "subscribem.middleware.warden" do
      Rails.application.config.middleware.use Warden::Manager do |manager|
        manager.default_strategies :password
      end
    end

    initializer "subscribem.middleware.apartment" do
      Rails.application.config.middleware.use Apartment::Elevators::Subdomain
    end

    isolate_namespace Subscribem

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    config.to_prepare do
      root = Subscribem::Engine.root
      extenders_path = root + "app/extenders/**/*.rb"
      Dir.glob(extenders_path) do |file|
        Rails.configuration.cache_classes ? require(file) : load(file)
      end
    end
  end
end
