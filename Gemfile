source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Rails
gem 'rails', '~> 5.1'
gem 'puma', '~> 3.7'

# Twelve factor app glue
gem 'dotenv-rails'
gem 'lograge'

# Database and related tools
gem 'pg'
gem 'delayed_job_active_record'
gem 'closure_tree'
gem 'virtus'

# User authentication and administration
gem 'devise', '~> 4', '>= 4.4.0'
gem 'devise-i18n'

# Internationalization
gem 'rails-i18n', '= 5.1.1'
gem 'twitter_cldr'

# Textual analysis
gem 'rsolr', '>= 1.0.7'
gem 'rsolr-ext'
gem 'cheetah'
gem 'distribution'
gem 'fast-stemmer'

# Citation processing
gem 'bibtex-ruby', require: 'bibtex'
gem 'citeproc-ruby', '~> 1.0'
gem 'csl-styles'

# Support for file attachments and exporting
gem 'paperclip', '~> 6'
gem 'aws-sdk-s3'
gem 'rubyzip', '>= 1.1.0', require: 'zip'
gem 'marc'
gem 'rdf', '>= 0.3.5'
gem 'rdf-vocab'
gem 'rdf-n3'

# Visualization
gem 'prawn'
gem 'rubysdl', '= 2.1.3.1'

# Asset tools and template generators
gem 'haml'
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'kramdown'
gem 'nokogiri'

# FIXME: Remove this dependency. It is fragile.
# Replace it with: https://github.com/bootstrap-ruby/rails-bootstrap-forms
# since all I'm using it for is styling.
gem 'simple_form', '>= 3.5.0'

gem 'uglifier', '>= 1.3.0'
gem 'mini_racer'

gem 'multi_mail'
gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

# Testing
group :test, :development do
  gem 'mocha', require: false
  gem 'factory_bot_rails'

  gem 'capybara', '~> 2.13'
  # gem 'capybara-slow_finder_errors'
  gem 'capybara-webkit'

  gem 'listen', '>= 3.0.5'
end

group :test do
  gem 'webmock', '>= 1.22.6', require: false

  gem 'pdf-inspector', require: false

  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end
