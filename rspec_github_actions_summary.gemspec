# frozen_string_literal: true

require_relative 'lib/rspec_github_actions_summary/version'

Gem::Specification.new do |spec|
  spec.name = 'rspec-github-actions-summary'
  spec.version = RspecGithubActionsSummary::VERSION
  spec.authors = ['seb']
  spec.email = ['gore.sebyx@yahoo.com']

  spec.summary = 'RSpec formatter for Github Actions Summary'
  spec.description = 'RSpec formatter for Github Actions Summary'
  spec.homepage = 'https://github.com/sebyx07/rspec-github-actions-summary'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = ['rspec-gh-summary']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rubocop', '>= 1.0.0'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_runtime_dependency 'rggen-core'
  spec.add_runtime_dependency 'rggen-markdown'
  spec.add_runtime_dependency 'rspec', '>= 2.0'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
