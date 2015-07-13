require 'spec_helper'

RSpec.describe TermDatesJob, type: :job do
  before(:example) do
    @user = create(:user)
    @dataset = create(:full_dataset, working: true, entries_count: 1,
                                     user: @user)
    @dataset.entries += [create(:entry, dataset: @dataset,
                                        uid: 'gutenberg:3172')]
    @task = create(:task, dataset: @dataset)
  end

  it_should_behave_like 'an analysis job' do
    let(:job_params) { { term: 'disease' } }
  end

  describe '.download?' do
    it 'is false' do
      expect(described_class.download?).to be false
    end
  end

  describe '.num_datasets' do
    it 'is 1' do
      expect(described_class.num_datasets).to eq(1)
    end
  end

  describe('.perform') do
    before(:example) do
      described_class.new.perform(
        @user.to_param,
        @dataset.to_param,
        @task.to_param,
        term: 'disease')
      @task.reload
      @data = JSON.load(@task.result.file_contents(:original))
    end

    it 'names the task correctly' do
      expect(@dataset.tasks[0].name).to eq('Plot word occurrences by date')
    end

    it 'creates good JSON' do
      expect(@data).to be_a(Hash)
    end

    it 'fills in some values' do
      expect(@data['data'][0][0]).to be_in([1895, 2009])
      expect((0..1)).to cover(@data['data'][0][1])
    end

    it 'fills in some zeroes in intervening years' do
      elt = @data['data'].find { |y| y[1] == 0 }
      expect(elt).to be
    end
  end
end