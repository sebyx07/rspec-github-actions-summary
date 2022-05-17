# frozen_string_literal: true

class RspecGithubActionsSummary
  class ExampleGroup
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def write_row
      [
        passed? ? '✅ Pass' : '❌ Failed',
        json['passed_specs'],
        json['failed_specs'],
        json['skipped_specs'],
        json['total_specs'],
        duration
      ]
    end

    def render_failed_examples
      return [] if json['failed'].empty?

      json['failed'].map do |j|
        "bin/rspec #{j["path"]} # #{j["desc"]}"
      end
    end

    private

    def duration
      helper_humanize_secs(json['duration'])
    end

    def passed?
      json['failed_specs'].zero?
    end

    def json
      @json ||= JSON.parse(File.read(file_path))
    end

    def helper_humanize_secs(secs)
      [[60, :seconds], [60, :minutes], [24, :hours], [Float::INFINITY, :days]].map do |count, name|
        next unless secs.positive?

        secs, n = secs.divmod(count)

        "#{n.to_i} #{name}" unless n.to_i.zero?
      end.compact.reverse.join(' ')
    end
  end
end
