# -*- encoding: utf-8 -*-
# stub: ace-rails-ap 4.5 ruby lib

Gem::Specification.new do |s|
  s.name = "ace-rails-ap".freeze
  s.version = "4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Cody Krieger".freeze]
  s.date = "2023-01-12"
  s.description = "The Ajax.org Cloud9 Editor (Ace) for the Rails 3.1 asset pipeline.".freeze
  s.email = ["cody@codykrieger.com".freeze]
  s.homepage = "https://github.com/codykrieger/ace-rails-ap".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.22".freeze
  s.summary = "The Ajax.org Cloud9 Editor (Ace) for the Rails 3.1 asset pipeline.".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
  end
end
