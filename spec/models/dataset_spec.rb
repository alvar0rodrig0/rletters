require 'spec_helper'

RSpec.describe Dataset, type: :model do
  describe '#valid?' do
    context 'when name is not specified' do
      before(:example) do
        @dataset = build_stubbed(:dataset, name: nil)
      end

      it 'is not valid' do
        expect(@dataset).not_to be_valid
      end
    end

    context 'when user is not specified' do
      before(:example) do
        @dataset = build_stubbed(:dataset, user: nil)
      end

      it 'is not valid' do
        expect(@dataset).not_to be_valid
      end
    end

    context 'when user and name are specified' do
      before(:example) do
        @dataset = create(:dataset)
      end

      it 'is valid' do
        expect(@dataset).to be_valid
      end
    end
  end

  describe '#tasks' do
    context 'when an task is created' do
      before(:example) do
        @dataset = create(:dataset)
        @task = create(:task, dataset: @dataset, name: 'test')
      end

      after(:example) do
        @task.destroy
        @dataset.destroy
      end

      it 'has one task' do
        expect(@dataset.tasks.size).to eq(1)
      end

      it 'points to the right task' do
        expect(@dataset.tasks[0].name).to eq('test')
      end
    end
  end

  describe '#entries' do
    context 'when creating a new dataset' do
      before(:example) do
        @user = create(:user)
        @dataset = create(:full_dataset, user: @user, entries_count: 2)
      end

      it 'is connected to the user' do
        @user.datasets.reload
        expect(@user.datasets.active.size).to eq(1)
      end

      it 'has the right number of entries' do
        expect(@dataset.entries.size).to eq(2)
      end
    end
  end
end
