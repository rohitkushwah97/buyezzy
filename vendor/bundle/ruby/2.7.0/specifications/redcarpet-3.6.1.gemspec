# -*- encoding: utf-8 -*-
# stub: redcarpet 3.6.1 ruby lib
# stub: ext/redcarpet/extconf.rb

Gem::Specification.new do |s|
  s.name = "redcarpet".freeze
  s.version = "3.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Natacha Port\u00E9".freeze, "Vicent Mart\u00ED".freeze]
  s.date = "2025-02-25"
  s.description = "A fast, safe and extensible Markdown to (X)HTML parser".freeze
  s.email = "vicent@github.com".freeze
  s.executables = ["redcarpet".freeze]
  s.extensions = ["ext/redcarpet/extconf.rb".freeze]
  s.extra_rdoc_files = ["COPYING".freeze]
  s.files = ["COPYING".freeze, "bin/redcarpet".freeze, "ext/redcarpet/extconf.rb".freeze]
  s.homepage = "https://github.com/vmg/redcarpet".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Markdown that smells nice".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, ["~> 13"])
    s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.5"])
  else
    s.add_dependency(%q<rake>.freeze, ["~> 13"])
    s.add_dependency(%q<rake-compiler>.freeze, ["~> 1.1"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.5"])
  end
end
