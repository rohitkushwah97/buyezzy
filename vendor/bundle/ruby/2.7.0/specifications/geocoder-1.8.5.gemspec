# -*- encoding: utf-8 -*-
# stub: geocoder 1.8.5 ruby lib

Gem::Specification.new do |s|
  s.name = "geocoder".freeze
  s.version = "1.8.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/alexreisner/geocoder/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/alexreisner/geocoder" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Reisner".freeze]
  s.date = "2024-12-18"
  s.description = "Object geocoding (by street or IP address), reverse geocoding (coordinates to street address), distance queries for ActiveRecord and Mongoid, result caching, and more. Designed for Rails but works with Sinatra and other Rack frameworks too.".freeze
  s.email = ["alex@alexreisner.com".freeze]
  s.executables = ["geocode".freeze]
  s.files = ["bin/geocode".freeze]
  s.homepage = "http://www.rubygeocoder.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Complete geocoding solution for Ruby.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<base64>.freeze, [">= 0.1.0"])
    s.add_runtime_dependency(%q<csv>.freeze, [">= 3.0.0"])
  else
    s.add_dependency(%q<base64>.freeze, [">= 0.1.0"])
    s.add_dependency(%q<csv>.freeze, [">= 3.0.0"])
  end
end
