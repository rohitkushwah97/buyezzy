# -*- encoding: utf-8 -*-
# stub: validates_timeliness 6.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "validates_timeliness".freeze
  s.version = "6.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/adzap/validates_timeliness/issues", "changelog_uri" => "https://github.com/adzap/validates_timeliness/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/adzap/validates_timeliness", "wiki_uri" => "https://github.com/adzap/validates_timeliness/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Meehan".freeze]
  s.date = "2023-01-12"
  s.description = "Adds validation methods to ActiveModel for validating dates and times. Works with multiple ORMS.".freeze
  s.email = "adam.meehan@gmail.com".freeze
  s.extra_rdoc_files = ["README.md".freeze, "CHANGELOG.md".freeze, "LICENSE".freeze]
  s.files = ["CHANGELOG.md".freeze, "LICENSE".freeze, "README.md".freeze]
  s.homepage = "https://github.com/adzap/validates_timeliness".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Date and time validation plugin for Rails which allows custom formats".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activemodel>.freeze, [">= 6.0.0", "< 7"])
    s.add_runtime_dependency(%q<timeliness>.freeze, [">= 0.3.10", "< 1"])
  else
    s.add_dependency(%q<activemodel>.freeze, [">= 6.0.0", "< 7"])
    s.add_dependency(%q<timeliness>.freeze, [">= 0.3.10", "< 1"])
  end
end
