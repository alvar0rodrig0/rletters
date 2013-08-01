# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "jobs/single_term_vectors/results" do
  
  before(:each) do
    # RSpec isn't smart enough to read our routes for us, so set
    # things manually here.
    controller.controller_path = "datasets"
    controller.request.path_parameters[:controller] = "datasets"

    @dataset = FactoryGirl.create(:dataset)
    @task = FactoryGirl.create(:analysis_task, :name => "Term frequency information",
                               :job_type => 'SingleTermVectors', :dataset => @dataset)
    @task.result_file = Download.create_file('temp.yml') do |file|
      file.write({ "test" => { :tf => 3, :df => 1, :tfidf => 2.5 }}.with_indifferent_access.to_yaml)
      file.close
    end
    @task.save
  end
  
  after(:each) do
    @task.destroy
  end
  
  it 'shows the term and values in a table row' do
    render
    
    rendered.should have_tag('tbody tr') do
      with_tag('td', :text => 'test')
      with_tag('td', :text => '3')
      with_tag('td', :text => '1')
      with_tag('td', :text => '2.5')
    end
  end
  
  it "has a link to download the results as CSV" do
    render
    
    expected = url_for(:controller => 'datasets', :action => 'task_view', 
      :id => @dataset.to_param, :task_id => @task.to_param, 
      :view => 'download', :format => 'csv')
    rendered.should have_tag("a[href='#{expected}']")
  end
  
end
