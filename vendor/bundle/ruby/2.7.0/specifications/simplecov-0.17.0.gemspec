# -*- encoding: utf-8 -*-
# stub: simplecov 0.17.0 ruby lib

Gem::Specification.new do |s|
  s.name = "simplecov".freeze
  s.version = "0.17.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Christoph Olszowka".freeze]
  s.date = "2019-07-02"
  s.description = "Code coverage for Ruby 1.9+ with a powerful configuration library and automatic merging of coverage across test suites".freeze
  s.email = ["christoph at olszowka de".freeze]
  s.homepage = "http://github.com/colszowka/simplecov".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Code coverage for Ruby 1.9+ with a powerful configuration library and automatic merging of coverage across test suites".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<json>.freeze, [">= 1.8", "< 3"])
    s.add_runtime_dependency(%q<simplecov-html>.freeze, ["~> 0.10.0"])
    s.add_runtime_dependency(%q<docile>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<cucumber>.freeze, ["< 3"])
    s.add_development_dependency(%q<aruba>.freeze, [">= 0"])
    s.add_development_dependency(%q<capybara>.freeze, ["< 3"])
    s.add_development_dependency(%q<phantomjs>.freeze, [">= 0"])
    s.add_development_dependency(%q<poltergeist>.freeze, [">= 0"])
  else
    s.add_dependency(%q<json>.freeze, [">= 1.8", "< 3"])
    s.add_dependency(%q<simplecov-html>.freeze, ["~> 0.10.0"])
    s.add_dependency(%q<docile>.freeze, ["~> 1.1"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<cucumber>.freeze, ["< 3"])
    s.add_dependency(%q<aruba>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, ["< 3"])
    s.add_dependency(%q<phantomjs>.freeze, [">= 0"])
    s.add_dependency(%q<poltergeist>.freeze, [">= 0"])
  end
end
