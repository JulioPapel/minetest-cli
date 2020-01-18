require "bundler/gem_tasks"
require "github_changelog_generator/task"
require "./lib/helpers/file_helper"

task :default => :spec


GitHubChangelogGenerator::RakeTask.new :changelog_gen do |config|
  config.user = 'JulioPapel'
  config.project = 'minetest-cli'
  # config.token = "YOUR GITHUB TOKEN"
  config.future_release = 'v1.0'
  config.release_branch = "master"
  config.date_format = "%d-%m-%Y"
  config.header = "# Minetest Changes Log."
  config.simple_list = true

end
Rake::Task['changelog_gen'].clear_comments

desc 'Compile the changelog file from github commits, issues, etc..'
task :changelog do
  Rake::Task['changelog_gen'].invoke
  helper = Minetest::Helpers::FileHelper.new
  helper.remove_lines("CHANGELOG.md", 9, 1)
  helper.append_lines("CHANGELOG.md", "Last updated by: Júlio Papel")
end

