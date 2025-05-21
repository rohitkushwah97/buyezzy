# -*- encoding: utf-8 -*-
# stub: city-state 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "city-state".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Loureiro".freeze]
  s.date = "2023-08-14"
  s.description = "Useful to make forms and validations. It uses MaxMind database.".freeze
  s.email = ["loureirorg@gmail.com".freeze]
  s.homepage = "https://github.com/thecodecrate/city-state".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Simple list of cities and states of the world".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.7"])
    s.add_development_dependency(%q<rake>.freeze, [">= 11.0"])
    s.add_runtime_dependency(%q<rubyzip>.freeze, [">= 2.3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.10"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.7"])
    s.add_dependency(%q<rake>.freeze, [">= 11.0"])
    s.add_dependency(%q<rubyzip>.freeze, [">= 2.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.10"])
  end
end
