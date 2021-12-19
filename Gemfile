source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '~> 0.10.0'

# Pretty print Ruby objects with proper indentation and colors
# (http://github.com/michaeldv/awesome_print)
gem 'awesome_print', '1.8.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Attributes on Steroids for Plain Old Ruby Objects
# (https://github.com/solnic/virtus)
gem 'virtus'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  
  gem 'pry-rails'

  ### TESTING ###
  # RSpec matchers for database queries.
  gem 'db-query-matchers', '0.10.0'

  gem 'rubocop', '~> 1.7'
  gem 'rubocop-rspec-focused', '0.1.0'
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false

  gem 'guard-rubocop'
  gem 'guard-rspec', require: false

  # RSpec for Rails (http://github.com/rspec/rspec-rails)
  gem 'rspec-rails'

  # Making tests easy on the fingers and eyes
  # (http://thoughtbot.com/community/)
  gem 'shoulda-matchers', '~> 4.2', require: false

  # Factory Bot ♥ Rails (https://github.com/thoughtbot/factory_bot_rails)
  gem 'factory_bot_rails', '4.11.0' # search

  # Strategies for cleaning databases.  Can be used to ensure a clean state for
  # testing. (http://github.com/DatabaseCleaner/database_cleaner)
  gem 'database_cleaner' # search
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
