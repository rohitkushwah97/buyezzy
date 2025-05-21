# -*- encoding: utf-8 -*-
# stub: numbers_and_words 0.11.11 ruby lib

Gem::Specification.new do |s|
  s.name = "numbers_and_words".freeze
  s.version = "0.11.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kirill Lazarev".freeze]
  s.date = "2021-07-05"
  s.description = "This gem spells out numbers in several languages using the I18n gem.".freeze
  s.email = "k.s.lazarev@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/kslazarev/numbers_and_words".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Spell out numbers in several languages".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<i18n>.freeze, ["<= 2"])
    s.add_development_dependency(%q<jeweler>.freeze, ["~> 2"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12"])
  else
    s.add_dependency(%q<i18n>.freeze, ["<= 2"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2"])
    s.add_dependency(%q<rake>.freeze, ["~> 12"])
  end
end
