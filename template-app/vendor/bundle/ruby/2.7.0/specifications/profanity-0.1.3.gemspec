# -*- encoding: utf-8 -*-
# stub: profanity 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "profanity".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Marcin \u015Awi\u0105tkiewicz".freeze]
  s.date = "2015-06-18"
  s.description = "This gem provide you to check if in text is any profanity words, text can be without white characters like space and this still will be work".freeze
  s.email = ["m.swiatkiewicz91@gmail.com".freeze]
  s.homepage = "http://github.com/efigence/profanity".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "This gem detect profanity words in text".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
  end
end
