# frozen_string_literal: true

require 'rspec/core/formatters'
require_relative 'rspec_github_actions_summary/version'
require_relative 'rspec_github_actions_summary/output'

class RspecGithubActionsSummary
  class Error < StandardError; end
  RSpec::Core::Formatters.register self, :dump_summary

  def initialize(output)
    @output = output
  end

  def dump_summary(notification)
    RspecGithubActionsSummary::TempFileResult.new(notification).write!
  end
end
