# -*- encoding: utf-8 -*-
# stub: docx 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "docx".freeze
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Christopher Hunt".freeze, "Marcus Ortiz".freeze, "Higgins Dragon".freeze, "Toms Mikoss".freeze, "Sebastian Wittenkamp".freeze]
  s.date = "2023-05-20"
  s.description = "thin wrapper around rubyzip and nokogiri as a way to get started with docx files".freeze
  s.email = ["chrahunt@gmail.com".freeze]
  s.homepage = "https://github.com/chrahunt/docx".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "a ruby library/gem for interacting with .docx files".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.13", ">= 1.13.0"])
    s.add_runtime_dependency(%q<rubyzip>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<coveralls_reborn>.freeze, ["~> 0.21"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
  else
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.13", ">= 1.13.0"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 2.0"])
    s.add_dependency(%q<coveralls_reborn>.freeze, ["~> 0.21"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
  end
end
