# frozen_string_literal: true

describe RspecGithubActionsSummary::TempFileResult do
  let(:failed_examples) do
    [ExampleRspec.new(:failed)]
  end
  let(:passed_examples) do
    [ExampleRspec.new(:passed), ExampleRspec.new(:passed)]
  end
  let(:pending_examples) do
    [ExampleRspec.new(:skipped)]
  end

  let(:notification) do
    NotificationRspec.new.tap do |n|
      n.failed_examples = failed_examples
      n.passed_examples = passed_examples
      n.pending_examples = pending_examples
      n.duration = 10
    end
  end

  let(:tempfile_result) { described_class.new(notification) }

  describe '#write!' do
    subject(:write!) { described_class.new(notification).write! }

    let(:root_path) { tempfile_result.send(:root_path) }
    let(:path) { tempfile_result.send(:path) }

    before do
      expect(FileUtils).to receive(:mkdir_p).with([root_path])
      expect(File).to receive(:open).with(path, 'w')
    end

    it 'writes the temp files' do
      write!
    end
  end

  describe 'private result' do
    let(:result) { tempfile_result.send(:result) }
    let(:good_result) do
      {
        total_specs: 4,
        passed_specs: 2,
        failed_specs: 1,
        skipped_specs: 1,
        duration: 10,
        failed: [{ desc: 'Example description', path: 'path_to_spec' }]
      }
    end

    it 'equals' do
      expect(result).to eq(good_result)
    end
  end
end
