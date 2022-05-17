# frozen_string_literal: true

describe RspecGithubActionsSummary::Output do
  let(:output) { described_class.new }

  describe 'output' do
    let(:example_groups) { [RspecGithubActionsSummary::ExampleGroup.new(nil)] }
    let(:good_output) do
      <<~MD
        # Test results

        |Test Result|Passed ✅|Failed ❌|Skipped 🔃|Total|Time duration ⏰|
        |:--|:--|:--|:--|:--|:--|
        |❌ Failed|2|1|1|4|10 seconds|

        ---
        ## Failed specs
        ```bash
        bin/rspec path_to_spec # Example description
        ```

        ---
        Job run summary generated at run-time by [RSpec Github Actions Summary](https://github.com/sebyx07/rspec-github-actions-summary)
      MD
    end
    let(:json) do
      {
        total_specs: 4,
        passed_specs: 2,
        failed_specs: 1,
        skipped_specs: 1,
        duration: 10,
        failed: [{ 'desc' => 'Example description', 'path' => 'path_to_spec' }]
      }.transform_keys(&:to_s)
    end

    before do
      expect_any_instance_of(RspecGithubActionsSummary::ExampleGroup).to receive(:json).at_least(:once).and_return(json)
      expect(output).to receive(:example_groups).at_least(:once).and_return(example_groups)
    end

    it 'outputs markdown' do
      expect(output.output).to eq(good_output)
    end
  end
end
