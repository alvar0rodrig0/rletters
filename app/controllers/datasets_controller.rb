# frozen_string_literal: true

# Display, modify, delete, and analyze datasets belonging to a given user
#
# This controller is responsible for the handling of the datasets which
# belong to a given user.  It displays the user's list of datasets, and
# handles the starting and management of the user's background analysis
# tasks.
#
# @see Dataset
class DatasetsController < ApplicationController
  before_action :authenticate_user!

  # Show all of the current user's datasets
  #
  # @return [void]
  def index
    @datasets = current_user.datasets

    # If this is an AJAX request, render the dataset table only
    if request.xhr?
      disable_browser_cache
      render :index_xhr, layout: false
    else
      render
    end
  end

  # Show information about the requested dataset
  #
  # This action also includes links for users to perform various analysis
  # tasks on the dataset.
  #
  # @return [void]
  def show
    @dataset = current_user.datasets.find(params[:id])

    # Clear failed tasks if requested
    return unless params[:clear_failed] && !@dataset.tasks.failed.empty?

    @dataset.tasks.failed.destroy_all
    flash[:notice] = t('datasets.show.deleted')
  end

  # Show the form for creating a new dataset
  #
  # @return [void]
  def new
    @dataset = current_user.datasets.build
    render layout: false
  end

  # Create a new dataset in the database
  #
  # @return [void]
  def create
    dataset = current_user.datasets.create(name: dataset_params[:name])
    dataset.queries.create(q: params[:q], fq: params[:fq],
                           def_type: params[:def_type])

    if current_user.workflow_active
      current_user.workflow_datasets << dataset.to_param
      current_user.save

      redirect_to workflow_activate_path(current_user.workflow_class),
                  flash: { success: I18n.t('datasets.create.workflow') }
    else
      redirect_to datasets_path,
                  flash: { success: I18n.t('datasets.create.success') }
    end
  end

  # Delete a dataset from the database
  #
  # @return [void]
  def destroy
    @dataset = current_user.datasets.find(params[:id])
    @dataset.destroy

    redirect_to datasets_path
  end

  # Add a single document to a dataset
  #
  # This is an odd update method.  The only attribute that we allow you to send
  # in here is the UID of a single document to be added into the dataset.
  # Any other attempts to PATCH dataset attributes will be silently ignored.
  #
  # @return [void]
  def update
    raise ActionController::ParameterMissing, :uid unless params[:uid]

    @dataset = current_user.datasets.find(params[:id])
    @document = Document.find(params[:uid])

    @dataset.queries.create(q: "uid:\"#{params[:uid]}\"", def_type: 'lucene')
    redirect_to dataset_path(@dataset)
  end

  private

  # Whitelist acceptable dataset parameters
  #
  # @return [ActionController::Parameters] acceptable parameters for
  #   mass-assignment
  def dataset_params
    params.require(:dataset).permit(:name)
  end
end
