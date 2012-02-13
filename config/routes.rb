# -*- encoding : utf-8 -*-

RLetters::Application.routes.draw do
  # Search/Browse page
  match 'search' => 'search#index', :via => :get
  match 'search/advanced' => 'search#advanced', :via => :get
  match 'search/document/:id' => 'search#show', :via => :get, :as => 'search_show'
  match 'search/document/:id/mendeley' => 'search#to_mendeley', :via => :get, :as => 'mendeley_redirect'
  match 'search/document/:id/citeulike' => 'search#to_citeulike', :via => :get, :as => 'citeulike_redirect'

  # Datasets (per-user)
  resources :datasets, :except => [ :edit, :update ] do
    member do
      get 'task_list'
      get 'delete'
      get 'task/:class/start' => 'datasets#task_start', :constraints => { :class => /[A-Z][A-Za-z]+/u }
      get 'task/:task_id/view/:view' => 'datasets#task_view', :constraints => { :task_id => /[0-9]+/u }
      get 'task/:task_id/destroy' => 'datasets#task_destroy', :constraints => { :task_id => /[0-9]+/u }
      get 'task/:task_id/download' => 'datasets#task_download', :constraints => { :task_id => /[0-9]+/u }
    end
  end

  # Custom login built around Janrain Engage
  resource :user, :except => [ :destroy, :edit ] do
    member do
      post 'rpx'
      get 'login'
      get 'logout'
    end
    
    resources :libraries, :except => :show do
      member do
        get 'delete'
      end
      collection do
        get 'query'
      end
    end
  end

  # Static information pages
  match 'info' => 'info#index', :via => :get
  match 'info/about' => 'info#about', :via => :get
  match 'info/faq' => 'info#faq', :via => :get
  match 'info/privacy' => 'info#privacy', :via => :get
  match 'info/tutorial' => 'info#tutorial', :via => :get

  # unAPI service
  match 'unapi' => 'unapi#index', :via => :get

  # Start off on the info/home page
  root :to => 'info#index'
end
