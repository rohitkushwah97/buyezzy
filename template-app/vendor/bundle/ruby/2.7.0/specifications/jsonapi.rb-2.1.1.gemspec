# -*- encoding: utf-8 -*-
# stub: jsonapi.rb 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jsonapi.rb".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stas Suscov".freeze]
  s.date = "2024-06-23"
  s.description = "JSON:API serialization, error handling, filtering and pagination.".freeze
  s.email = ["stas@nerd.ro".freeze]
  s.homepage = "https://github.com/stas/jsonapi.rb".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "Install manually `ransack` gem before using `JSONAPI::Filtering`!".freeze
  s.rubygems_version = "3.3.22".freeze
  s.summary = "So you say you need JSON:API support in your API...".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<jsonapi-serializer>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<ransack>.freeze, [">= 0"])
    s.add_development_dependency(%q<railties>.freeze, [">= 0"])
    s.add_development_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<ffaker>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<jsonapi-rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<yardstick>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop-rails_config>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop-performance>.freeze, [">= 0"])
  else
    s.add_dependency(%q<jsonapi-serializer>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<ransack>.freeze, [">= 0"])
    s.add_dependency(%q<railties>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.7"])
    s.add_dependency(%q<ffaker>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<jsonapi-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<yardstick>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-rails_config>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop-performance>.freeze, [">= 0"])
  end
end
