require "uri"
require "net/http"
require_relative "../builder_base"

desc "Outputs block gem versions including direct and indirect dependencies"
task :blocks_gem_versions do
  block_gems = BuilderBase.list_block_gems

  puts JSON.pretty_generate({
    project_gems: block_gems.map { |block| {gem_name: block.name, gem_version: block.version.version} }
  })
end

desc "Outputs the project infrastructure requirements gathering all block infra dependencies"
task :blocks_infra_requirements do
  infra_deps = BuilderBase.list_block_gems
    .flat_map { |block| String(block.metadata["infra_dependencies"]).split(",").map(&:squish) }

  unique_deps = infra_deps.uniq.sort

  uri = URI("https://api.cat.builder.ai/v1/infrastructure/backend?format=json")
  res = Net::HTTP.get_response(uri)
  exit(1) unless res.is_a?(Net::HTTPSuccess)
  allowed_deps = JSON.parse(res.body).keys

  invalid_deps = unique_deps - allowed_deps
  if invalid_deps.empty?
    puts JSON.pretty_generate({infra_dependencies: unique_deps})
  else
    puts "Invalid infra dependencies: #{invalid_deps.join(", ")}."
    exit(1)
  end
end
