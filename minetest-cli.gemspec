require_relative 'lib/minetest/cli/version'

Gem::Specification.new do |spec|
  spec.name          = "minetest-cli"
  spec.version       = Minetest::Cli::VERSION
  spec.authors       = ["JulioPapel"]
  spec.email         = ["julio.papel@me.com"]

  spec.summary       = "A Minetest Server Custom tool"
  spec.description   = "Minetest Server CLI tool to manage the Server, worlds maps, etc.."
  spec.homepage      = "http://mywebsite.com/minetest-cli" # Your app website
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com" # Gem publishing server. Usually http://rubygems.org

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/JulioPapel/minetest-cli"
  spec.metadata["changelog_uri"] = "https://github.com/JulioPapel/minetest-cli/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'thor'
  spec.add_dependency 'httparty'
  spec.add_dependency 'highline'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "github_changelog_generator"
end
