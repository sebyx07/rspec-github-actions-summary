# frozen_string_literal: true

describe RspecGithubActionsSummary::Output do
  let(:output) { described_class.new }

  describe 'output' do
    let(:example_groups) { [RspecGithubActionsSummary::ExampleGroup.new(nil)] }
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
      print output.output
    end
  end
end
