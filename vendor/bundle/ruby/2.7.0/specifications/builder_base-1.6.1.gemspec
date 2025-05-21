# -*- encoding: utf-8 -*-
# stub: builder_base 1.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "builder_base".freeze
  s.version = "1.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com", "infra_dependencies" => "postgresql,redis" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Travis Herrick".freeze]
  s.date = "2025-01-16"
  s.email = ["travis.herrick@builder.ai".freeze]
  s.executables = ["create_builder_app".freeze, "create_namespace".freeze, "deploy_block".freeze, "finalize_builder_app".freeze, "install_blocks".freeze, "trigger_pipeline".freeze, "update_bds".freeze]
  s.files = ["bin/create_builder_app".freeze, "bin/create_namespace".freeze, "bin/deploy_block".freeze, "bin/finalize_builder_app".freeze, "bin/install_blocks".freeze, "bin/trigger_pipeline".freeze, "bin/update_bds".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/builder_base".freeze
  s.required_ruby_version = Gem::Requirement.new([">= 2.6.5".freeze, "< 3.1".freeze])
  s.rubygems_version = "3.1.6".freeze
  s.summary = "BuilderBase".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 6.0.3.6", "<= 6.1.7.6"])
    s.add_runtime_dependency(%q<jsonapi.rb>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<fast_jsonapi>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<nokogiri>.freeze, ["= 1.13.10"])
    s.add_runtime_dependency(%q<net-imap>.freeze, ["= 0.3.7"])
    s.add_runtime_dependency(%q<zeitwerk>.freeze, ["< 2.7"])
    s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["< 1.3.5"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 6.0.3.6", "<= 6.1.7.6"])
    s.add_dependency(%q<jsonapi.rb>.freeze, [">= 0"])
    s.add_dependency(%q<fast_jsonapi>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, ["= 1.13.10"])
    s.add_dependency(%q<net-imap>.freeze, ["= 0.3.7"])
    s.add_dependency(%q<zeitwerk>.freeze, ["< 2.7"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["< 1.3.5"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
  end
end
