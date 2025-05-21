require "jsonapi"
require "fast_jsonapi"

require "builder_base/engine"

module BuilderBase
  def self.list_block_gems
    Bundler.load.specs.select { |gem| gem.metadata["allowed_push_host"] == "https://gemfury.com" }
  end
end
