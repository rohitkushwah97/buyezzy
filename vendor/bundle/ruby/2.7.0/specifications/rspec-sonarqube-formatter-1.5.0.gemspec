# -*- encoding: utf-8 -*-
# stub: rspec-sonarqube-formatter 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rspec-sonarqube-formatter".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/otherguy/rspec-sonarqube-formatter/issues", "source_code_uri" => "https://github.com/otherguy/rspec-sonarqube-formatter" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexander Graf".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-02-15"
  s.description = "Generates an XML report that the SonarQube Generic Test Data parser can understand".freeze
  s.email = ["alex@otherguy.uo".freeze]
  s.homepage = "https://github.com/otherguy/rspec-sonarqube-formatter".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Generic test data formatter for SonarQube".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<htmlentities>.freeze, ["~> 4.3.3"])
    s.add_runtime_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.2.0"])
    s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8.23"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0.1"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.10.0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_development_dependency(%q<simplecov-json>.freeze, ["~> 0.2.0"])
  else
    s.add_dependency(%q<htmlentities>.freeze, ["~> 4.3.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.2.0"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.23"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0.1"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.10.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_dependency(%q<simplecov-json>.freeze, ["~> 0.2.0"])
  end
end
