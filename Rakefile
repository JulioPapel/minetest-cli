require "bundler/gem_tasks"
require 'github_changelog_generator/task'
task :default => :spec

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'JulioPapel'
  config.project = 'minetest-cli'
  config.since_tag = 'v0.1'
  config.future_release = 'v1.0'
end