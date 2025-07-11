# -*- encoding: utf-8 -*-
# stub: active_admin_role 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "active_admin_role".freeze
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yoshiyuki Hirano".freeze]
  s.date = "2019-05-12"
  s.description = "Role based authorization with CanCanCan for Active Admin".freeze
  s.email = ["yhirano@me.com".freeze]
  s.homepage = "https://github.com/activeadmin-plugins/active_admin_role".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Role based authorization with CanCanCan for Active Admin".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 1.2.0"])
    s.add_runtime_dependency(%q<cancancan>.freeze, [">= 1.15.0"])
    s.add_runtime_dependency(%q<railties>.freeze, [">= 5.0.0"])
  else
    s.add_dependency(%q<activeadmin>.freeze, [">= 1.2.0"])
    s.add_dependency(%q<cancancan>.freeze, [">= 1.15.0"])
    s.add_dependency(%q<railties>.freeze, [">= 5.0.0"])
  end
end
