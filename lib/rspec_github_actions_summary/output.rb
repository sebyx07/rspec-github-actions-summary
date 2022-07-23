# frozen_string_literal: true

require 'rggen/core/facets'
require 'rggen/core/utility/code_utility/line'
require 'rggen/core/utility/code_utility/code_block'
require 'rggen/core/utility/code_utility'
require 'rggen/markdown/utility/table_formatter'
require_relative './temp_file_result'
require_relative './example_group'

class RspecGithubActionsSummary
  class Output
    class NoOutputFiles < StandardError; end

    def write
      print output
    end

    def output
      <<~MD
        # Test results

        #{results_table}

        #{failed_examples}
        ---
        Job run summary generated at run-time by [RSpec Github Actions Summary](https://github.com/sebyx07/rspec-github-actions-summary)
      MD
    end

    private

    def results_table
      RgGen::Markdown::Utility::TableFormatter.new.format(table_labels, table_rows)
    end

    def table_rows
      example_groups.map(&:write_row)
    end

    def example_groups
      return @example_groups if defined? @example_groups

      dir_path = RspecGithubActionsSummary::TempFileResult.root_path

      files = Dir.glob(dir_path.join('*.json')).select { |f| File.file? f }
      raise NoOutputFiles, "No files found in #{dir_path}" if files.empty?

      @example_groups = files.map { |f| RspecGithubActionsSummary::ExampleGroup.new(f) }
    end

    def table_labels
      ['Test Result', 'Passed ✅', 'Failed ❌', 'Skipped 🔃', 'Total', 'Time duration ⏰']
    end

    def failed_examples
      lines = example_groups.map(&:render_failed_examples).flatten
      return if lines.blank?

      <<~MD
        ---
        ## Failed specs
        ```bash
        #{lines.uniq.sort.join("\n")}
        ```
      MD
    end
  end
end
