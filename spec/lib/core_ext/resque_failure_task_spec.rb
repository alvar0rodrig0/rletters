require 'spec_helper'

module Jobs
  module Analysis
    # A job that always throws an exception
    class FailingJob < Jobs::Analysis::Base
      def self.queue
        :ui
      end

      def perform
        fail 'This job always fails'
      end

      def self.run_with_worker(task, job_params)
        # We have to do this in a funny way to actually call the failure
        # handlers.  Thanks to Matt Conway (github/wr0ngway/graylog2-resque)
        # for this code.
        Resque.enqueue(Jobs::Analysis::FailingJob, *job_params)

        worker = Resque::Worker.new(queue)
        def worker.done_working
          # Only work one job, then shut down
          super
          shutdown
        end

        job = worker.reserve
        worker.perform(job)
      end
    end
  end
end

RSpec.describe Resque::Failure::Task do
  before(:context) do
    Resque.inline = false
  end

  after(:context) do
    Resque.inline = true
  end

  describe '#save' do
    context 'with good parameters' do
      before(:example) do
        @user = create(:user)
        @dataset = create(:full_dataset, user: @user)
        @task = create(:task, dataset: @dataset, name: 'Failing task',
                              job_type: 'FailingJob')

        job_params = [@user.to_param, @dataset.to_param, @task.to_param]
        Jobs::Analysis::FailingJob.run_with_worker(@task, job_params)
      end

      it 'sets the failure bit on the task' do
        @task.reload
        expect(@task.failed).to be true
      end
    end

    context 'with bad parameters' do
      it 'handles the exception gracefully' do
        expect {
          Jobs::Analysis::FailingJob.run_with_worker(
            create(:task), ['asdf', 'asdf', 'asdf']
          )
        }.not_to raise_error
      end
    end
  end
end
