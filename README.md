# RSpec Github Actions Summary

Github Actions Summary for RSpec, works with or without rails. Compatible with [parallel_tests](https://github.com/grosser/parallel_tests) gem.

## Sample

# Test results

|Test Result|Passed ✅|Failed ❌|Skipped 🔃|Total|Time duration ⏰|
|:--|:--|:--|:--|:--|:--|
|❌ Failed|2|1|1|4|10 seconds|

---
## Failed specs
```bash
bin/rspec spec/failed_spec.rb # Example description
```

---
Job run summary generated at run-time by [RSpec Github Actions Summary](https://github.com/sebyx07/rspec-github-actions-summary)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rspec-github-actions-summary --group 'test'

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install rspec-github-actions-summary

## Usage

```ruby
# inside your spec_helper.rb, not necessary for rails
require 'rspec_github_actions_summary'
```

```text
# inside your .rspec
--format RspecGithubActionsSummary
```

```yaml
# inside .github/workflows/your-workflow.yml
- name: RSpec
  run: bundle exec rspec

# generate summary even if specs fail
- name: Generate summary
  if: always()
  run: bundle exec rspec-gh-summary >> $GITHUB_STEP_SUMMARY
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec_github_actions_summary. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sebyx07/rspec-github-actions-summary/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RspecGithubActionsSummary project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rspec_github_actions_summary/blob/master/CODE_OF_CONDUCT.md).
