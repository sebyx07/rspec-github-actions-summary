# frozen_string_literal: true
require 'digest'

class RspecGithubActionsSummary
  class TempFileResult
    attr_reader :notification

    def initialize(notification)
      @notification = notification
    end

    def write!
      FileUtils.mkdir_p([root_path])

      File.open(path, 'w') do |f|
        f.write(result.to_json)
      end
    end

    def self.root_path
      return @root_path if defined? @root_path

      current_path_hash = Digest::MD5.hexdigest(Dir.pwd)
      @root_path = Pathname.new("/tmp/.rspec-github-summary/#{current_path_hash}/")
    end

    private

    def total
      @total ||= notification.examples.size
    end

    def passed
      total - failed - skipped_specs
    end

    def failed
      @failed ||= notification.failed_examples.size
    end

    def path
      root_path.join("result#{ENV["TEST_ENV_NUMBER"]}.json")
    end

    def root_path
      self.class.root_path
    end

    def skipped_specs
      notification.pending_examples.size
    end

    def result
      {
        total_specs: total,
        passed_specs: passed,
        failed_specs: failed,
        skipped_specs: skipped_specs,
        duration: notification.duration.round,
        failed: notification.failed_examples.map do |ex|
          format_failed_example(ex)
        end
      }
    end

    def format_failed_example(ex)
      {
        path: notification.send(:rerun_argument_for, ex),
        desc: ex.full_description
      }
    end
  end
end
