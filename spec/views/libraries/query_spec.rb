# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "libraries/query" do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user) { @user }
    view.stub(:user_signed_in?) { true }
  end
  
  context 'when libraries are assigned' do
    before(:each) do
      assign(:libraries, [ { :name => 'University of Notre Dame', 
        :url => 'http://findtext.library.nd.edu:8889/ndu_local?' } ])
      render
    end
    
    it 'has a form for adding the library' do
      rendered.should have_tag('form')
    end
    
    it 'has an input field for the library name' do
      rendered.should have_tag("input[value='University of Notre Dame']")
    end
    
    it 'has an input field for the library URL' do
      rendered.should have_tag("input[value='http://findtext.library.nd.edu:8889/ndu_local?']")
    end
  end
  
  context 'when no libraries are assigned' do
    before(:each) do
      assign(:libraries, [ ])
      render
    end
    
    it 'has no library forms' do
      rendered.should_not have_tag('form')
    end
  end
  
end
