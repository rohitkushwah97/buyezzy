# -*- encoding: utf-8 -*-
# stub: sidekiq_alive 2.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sidekiq_alive".freeze
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/arturictus/sidekiq_alive/issues", "changelog_uri" => "https://github.com/arturictus/sidekiq_alive/releases", "documentation_uri" => "https://github.com/arturictus/sidekiq_alive/blob/v2.4.0/README.md", "homepage_uri" => "https://github.com/arturictus/sidekiq_alive", "source_code_uri" => "https://github.com/arturictus/sidekiq_alive" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrejs Cunskis".freeze, "Artur Pan\u0303ach".freeze]
  s.date = "2024-02-15"
  s.description = "SidekiqAlive offers a solution to add liveness probe of a Sidekiq instance.\n\nHow?\n\nA http server is started and on each requests validates that a liveness key is stored in Redis. If it is there means is working.\n\nA Sidekiq job is the responsable to storing this key. If Sidekiq stops processing jobs\nthis key gets expired by Redis an consequently the http server will return a 500 error.\n\nThis Job is responsible to requeue itself for the next liveness probe.\n".freeze
  s.email = ["andrejs.cunskis@gmail.com".freeze, "arturictus@gmail.com".freeze]
  s.homepage = "https://github.com/arturictus/sidekiq_alive".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.3.22".freeze
  s.summary = "Liveness probe for sidekiq on Kubernetes deployments.".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["> 1.16"])
    s.add_development_dependency(%q<debug>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rspec-sidekiq>.freeze, ["~> 4.0"])
    s.add_development_dependency(%q<rubocop-shopify>.freeze, ["~> 2.10"])
    s.add_development_dependency(%q<solargraph>.freeze, ["~> 0.50.0"])
    s.add_runtime_dependency(%q<gserver>.freeze, ["~> 0.0.1"])
    s.add_runtime_dependency(%q<sidekiq>.freeze, [">= 5", "< 8"])
  else
    s.add_dependency(%q<bundler>.freeze, ["> 1.16"])
    s.add_dependency(%q<debug>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rspec-sidekiq>.freeze, ["~> 4.0"])
    s.add_dependency(%q<rubocop-shopify>.freeze, ["~> 2.10"])
    s.add_dependency(%q<solargraph>.freeze, ["~> 0.50.0"])
    s.add_dependency(%q<gserver>.freeze, ["~> 0.0.1"])
    s.add_dependency(%q<sidekiq>.freeze, [">= 5", "< 8"])
  end
end
