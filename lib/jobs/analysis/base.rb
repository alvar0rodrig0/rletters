# -*- encoding : utf-8 -*-

module Jobs

  # Module containing all analysis jobs
  module Analysis

    # Base class for all analysis jobs
    #
    # All jobs act on a dataset with a user ID, so those are common to all
    # analysis jobs.  Also, we include some error handling code (via Airbrake).
    #
    # Analysis jobs are required to implement one view, and possibly a second,
    # located at +lib/jobs/analysis/views/(job)/*.html.haml+:
    #
    # - +start.html.haml+: This contains code for starting a job.  It will be
    #   placed inside a <ul> tag, and so should contain at least one list
    #   item.  Commonly, it will contain (i) a single list item for
    #   starting the job, (ii) multiple <li> tags for different ways of
    #   starting the job, or (iii) a nested <ul> that contains different
    #   ways of starting the job (which will be handled gracefully by
    #   jQuery Mobile).  Note that this should have at least one link to the
    #   appropriate invocation of +datasets#task_start+ to be useful.
    # - +results.html.haml+ (optional): Tasks may report their results in two
    #   different ways.  Some tasks (e.g., ExportCitations) just dump all of
    #   their results into a file (see +AnalysisTask#result_file+) for the
    #   user to download.  This is the default, for which +#download?+ returns
    #   +true+.  If +#download?+ is overridden to return +false+, then the
    #   job is expected to implement the +results+ view, which will show the
    #   user the results of the job in HTML form.  The standard way to do this
    #   is to write the job results out as YAML in +AnalysisTask#result_file+,
    #   and then to parse this YAML into HAML in the view.
    #
    # @!attribute user_id
    #   @return [String] the user that created this dataset
    # @!attribute dataset_id
    #   @return [String] the dataset to export
    class Base < Jobs::Base
      attr_accessor :user_id, :dataset_id

      # True if this job produces a download
      #
      # If true (default), then links to results of tasks will produce links to
      # download the result_file from that task.  If not, then the link to the
      # task results will point to the 'results' view for this job.  Override
      # this method to return false if you want to use the 'results' view.
      #
      # @api public
      # @return [Boolean] true if task produces a download, false otherwise
      # @example Get a link to the results of a task
      #   if task.job_class.download?
      #     link_to '', controller: 'datasets', action: 'task_download',
      #       id: dataset.to_param, task_id: task.to_param
      #   else
      #     link_to '', controller: 'datasets', action: 'task_view',
      #       id: dataset.to_param, task_id: task.to_param,
      #       view: 'results'
      #   end
      def self.download?
        true
      end

      # Get a list of all classes that are analysis jobs
      #
      # This method looks up all the defined job classes in +lib/jobs/analysis+
      # and returns them in a list so that we may loop over them (e.g., when
      # including all job-start markup).
      #
      # @api public
      # @return [Array<Class>] array of class objects
      # @example Render the 'start' view for all jobs
      #   Jobs::Analysis::Base.job_list.each do |klass|
      #     render template: klass.view_path('start'), ...
      #   end
      def self.job_list
        # Get all the classes defined in the Jobs::Analysis module
        analysis_files = Dir[Rails.root.join('lib',
                                             'jobs',
                                             'analysis',
                                             '*.rb')]
        classes = analysis_files.map do |f|
          next if File.basename(f) == 'base.rb'

          # This will raise a NameError if the class doesn't exist, but we want
          # that, because that means there's a file in lib/jobs/analysis that
          # doesn't respect Rails' naming conventions.
          ('Jobs::Analysis::' + File.basename(f, '.rb').camelize).constantize
        end
        classes.compact!

        # Make sure that worked
        classes.each do |c|
          return [] unless c.is_a?(Class)
        end

        classes
      end

      # Get the list of paths for this class's job views
      #
      # We let analysis jobs ship their own job view templates. This function
      # returns the name of that directory to be prepended into the Rails
      # view search path.
      #
      # When a job mixes in a concern, this method also supports the addition
      # of concern views.
      #
      # @api public
      # @return [Array<String>] the template directories to be added
      # @example Get the path to the ExportCitations views
      #   Jobs::Analysis::ExportCitations.view_paths
      #   # => ['#{Rails.root}/lib/jobs/analysis/views/export_citations']
      def self.view_paths
        # This turns 'Jobs::Analysis::ExportCitations' into 'export_citations'
        class_name = name.demodulize.underscore
        ret = [Rails.root.join('lib', 'jobs', 'analysis', 'views', class_name)]

        # FIXME: add concerns right here

        ret
      end

      # Set the analysis task fail bit on error
      #
      # Analysis tasks carry a +failed+ attribute that reports that the
      # underlying delayed job has failed.  That attribute is set in this
      # error handler.
      #
      # @api private
      # @param [Delayed::Job] job The job currently being run
      # @param [StandardError] exception The exception raised to cause the
      #   error
      # @return [undefined]
      def error(job, exception)
        if instance_variable_defined?(:@task) && @task
          @task.failed = true
          @task.save!
        end
        super
      end
    end

  end
end
