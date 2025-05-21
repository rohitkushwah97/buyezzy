# -*- encoding: utf-8 -*-
# stub: fcmpush 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fcmpush".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "https://github.com/miyataka/fcmpush", "source_code_uri" => "https://github.com/miyataka/fcmpush" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["miyataka".freeze]
  s.bindir = "exe".freeze
  s.date = "2025-01-05"
  s.email = ["voyager.3taka28@gmail.com".freeze]
  s.homepage = "https://github.com/miyataka/fcmpush".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.6".freeze, "< 3.5".freeze])
  s.rubygems_version = "3.3.22".freeze
  s.summary = "Firebase Cloud Messaging API wrapper for ruby, supports HTTP v1. And including access_token Auto Refresh feature!".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<google-apis-identitytoolkit_v3>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<net-http-persistent>.freeze, ["~> 4.0.1"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
  else
    s.add_dependency(%q<google-apis-identitytoolkit_v3>.freeze, [">= 0"])
    s.add_dependency(%q<net-http-persistent>.freeze, ["~> 4.0.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
