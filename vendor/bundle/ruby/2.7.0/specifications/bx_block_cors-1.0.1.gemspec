# -*- encoding: utf-8 -*-
# stub: bx_block_cors 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_cors".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com", "infra_dependencies" => "postgresql" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Marin Cabillas".freeze]
  s.date = "2023-12-21"
  s.email = ["daniel.cabillas@builder.ai".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/bx_block_cors".freeze
  s.rubygems_version = "3.1.6".freeze
  s.summary = "BxBlockCors".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_development_dependency(%q<cane>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
  else
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<cane>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end
