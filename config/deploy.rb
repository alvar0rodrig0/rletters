# -*- encoding : utf-8 -*-
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'deploy')

# Gem recipes (Bundler, whenever, delayed_job)
require 'bundler/capistrano'

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

require "delayed/recipes"
before "deploy:restart", "delayed_job:stop"
after "deploy:restart", "delayed_job:start"

after "deploy:stop", "delayed_job:stop"
after "deploy:start", "delayed_job:start"

# Local recipes
require 'capistrano_database'
require 'app_config'
require 'static_assets'

# Standard configuration options for fetching RLetters from GitHub
set :scm, :git
set :repository, "git@github.com:cpence/rletters.git"
set :branch, "master"
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :rails_env, "production"

# Your local application configuration
require 'deploy_config'
require 'passenger'
