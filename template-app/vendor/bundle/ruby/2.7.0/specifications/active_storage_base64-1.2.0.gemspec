# -*- encoding: utf-8 -*-
# stub: active_storage_base64 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "active_storage_base64".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ricardo Cortio".freeze]
  s.date = "2020-12-14"
  s.description = "Base64 support for ActiveStorage".freeze
  s.email = "ricardo@rootstrap.com".freeze
  s.homepage = "https://github.com/rootstrap/active-storage-base64".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.3.22".freeze
  s.summary = "Base64 support for ActiveStorage".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, ["~> 6.1"])
    s.add_development_dependency(%q<pry-rails>.freeze, ["~> 0.3.6"])
    s.add_development_dependency(%q<reek>.freeze, ["~> 5.5.0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.8.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.56.0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.17.1"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["= 1.4.1"])
  else
    s.add_dependency(%q<rails>.freeze, ["~> 6.1"])
    s.add_dependency(%q<pry-rails>.freeze, ["~> 0.3.6"])
    s.add_dependency(%q<reek>.freeze, ["~> 5.5.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.8.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.56.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.17.1"])
    s.add_dependency(%q<sqlite3>.freeze, ["= 1.4.1"])
  end
end
