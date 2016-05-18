source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'materialize-sass'

gem "font-awesome-rails"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.7'



# CarrierWave for uploading images
gem 'carrierwave', '0.10.0'
# mini_magick for image resizing
gem 'mini_magick', '3.8.0'
#listing search
gem 'sunspot_rails'

group :development do
  gem 'sunspot_solr'
end

#to help fix raty failed turbolink
gem 'jquery-turbolinks'
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug',                 '3.4.0'
  
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console',            '2.0.0.beta3'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',                 '1.1.3'
  
  gem 'mysql2', '>= 0.3.13', '< 0.5'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'puma'
end