$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "subscribem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "subscribem"
  s.version     = Subscribem::VERSION
  s.authors     = ["Bernardo Corbella"]
  s.email       = ["corbellabernardo@gmail.com"]
  s.homepage    = "http://github.com/bernardocorbella"
  s.summary     = "Subscribem Gem for Multitenancy with Rails book by Ryan Bigg"
  s.description = "A gem that subscribes people."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails', '2.14.0'
  s.add_development_dependency 'capybara', '2.1.0'
end
