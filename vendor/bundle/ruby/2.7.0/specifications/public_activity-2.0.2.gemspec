# -*- encoding: utf-8 -*-
# stub: public_activity 2.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "public_activity".freeze
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotrek Oko\u0144ski".freeze, "Kuba Oko\u0144ski".freeze]
  s.date = "2022-07-17"
  s.description = "Easy activity tracking for your ActiveRecord models. Provides Activity model with details about actions performed by your users, like adding comments, responding etc.".freeze
  s.email = "piotrek@okonski.org".freeze
  s.homepage = "https://github.com/pokonski/public_activity".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Easy activity tracking for ActiveRecord models".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<actionpack>.freeze, [">= 5.0.0"])
    s.add_runtime_dependency(%q<railties>.freeze, [">= 5.0.0"])
    s.add_runtime_dependency(%q<i18n>.freeze, [">= 0.5.0"])
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 5.0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.4.1"])
    s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<redcarpet>.freeze, [">= 0"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 5.0.0"])
    s.add_dependency(%q<railties>.freeze, [">= 5.0.0"])
    s.add_dependency(%q<i18n>.freeze, [">= 0.5.0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 5.0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.4.1"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
