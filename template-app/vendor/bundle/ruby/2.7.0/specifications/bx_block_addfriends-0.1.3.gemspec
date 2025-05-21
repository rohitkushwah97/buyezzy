# -*- encoding: utf-8 -*-
# stub: bx_block_addfriends 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_addfriends".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com", "infra_dependencies" => "" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vadym".freeze]
  s.date = "2024-05-01"
  s.email = ["vadym.yershov@cprime.com".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/bx_block_addfriends".freeze
  s.rubygems_version = "3.3.22".freeze
  s.summary = "BxBlockAddfriends".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<fcm>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_profile>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<active_storage_base64>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<activestorage>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
  else
    s.add_dependency(%q<fcm>.freeze, [">= 0"])
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_profile>.freeze, [">= 0"])
    s.add_dependency(%q<active_storage_base64>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<activestorage>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
  end
end
