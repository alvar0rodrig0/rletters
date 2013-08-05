source 'https://rubygems.org'

# Rails
gem 'rails', '~> 4.0'
gem 'rails-i18n', '= 0.7.2'

# Deployment and server tools
gem 'capistrano', require: false

gem 'god', require: false
gem 'unicorn', require: false

gem 'daemons', require: false
gem 'clockwork', require: false
gem 'delayed_job', '~> 4.0'
gem 'delayed_job_active_record'

gem 'airbrake', require: false

# Database and related tools
group :production, :development do
  gem 'pg'
end
group :test do
  gem 'sqlite3'
end
gem 'activerecord-import', '>= 0.4.0'
gem 'druthers'
gem 'addressable'

# User authentication and administration
gem 'devise'
gem 'devise-i18n'
gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4'
gem 'formtastic', '>= 2.3.0.rc' # FIXME: only for AA
gem 'responders', github: 'plataformatec/responders' # FIXME: only for AA
gem "ransack", github: "ernie/ransack", branch: "rails-4" # FIXME: only for AA

# Support for file attachments and exporting
gem 'paperclip', '~> 3.0'
gem 'rubyzip'
gem 'rsolr', '>= 1.0.7'
gem 'rsolr-ext'
gem 'marc'
gem 'rdf', '>= 0.3.5'
gem 'rdf-rdfxml'
gem 'rdf-n3'

# Support for citation processing
gem 'unicode', '>= 0.4.3.1.pre1'
gem 'latex-decode', '>= 0.0.11'
gem 'bibtex-ruby', '~> 2.0', require: 'bibtex'
gem 'citeproc-ruby', '>= 0.0.4'

# Asset tools and template generators
gem 'haml'
gem 'haml-rails'
gem 'kramdown'
gem 'coffee-rails'
gem 'sass-rails'

gem 'jquery-rails', '= 3.0.4'
gem 'jquery_mobile_rails', '= 1.3.2'

gem 'uglifier', '>= 1.3.0'
gem 'yui-compressor'

group :test, :development do
  gem 'rspec-rails'
  gem 'coveralls', require: false
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-html-matchers'
  gem 'vcr', require: false
  gem 'webmock', require: false
  gem 'nokogiri', require: false
end

group :development do
  gem 'yard', require: false

  gem 'magic_encoding', require: false
  gem 'yardstick', require: false
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'excellent', require: false
end
