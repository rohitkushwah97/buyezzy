# -*- encoding: utf-8 -*-
# stub: gserver 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "gserver".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John W. Small".freeze, "SHIBATA Hiroshi".freeze]
  s.date = "2014-08-15"
  s.description = "GServer implements a generic server".freeze
  s.email = ["hsbt@ruby-lang.org".freeze]
  s.homepage = "".freeze
  s.licenses = ["Ruby".freeze]
  s.rubygems_version = "3.3.22".freeze
  s.summary = "GServer implements a generic server".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
