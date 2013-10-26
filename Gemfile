source 'https://rubygems.org'

ruby "2.0.0"

#Rails gems
gem 'rails', '4.0.0'
gem 'pg'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

#gem 'jbuilder', '~> 1.2'

#To Heroku deploy
gem 'rails_12factor', group: :production

#my app
#uploads
gem 'paperclip'
#paginacao
gem 'will_paginate'
#controle de acesso e autenticacao
gem 'devise'
gem 'omniauth-facebook'

#cache
gem 'memcachier'
gem 'dalli'
#gem "iron_cache_rails" #, :git => 'git://github.com/milfont/iron_cache_rails.git'

#busca textual
gem 'tire'

gem 'jbuilder'
gem 'elasticsearch'

#transformar os controllers em js
gem "djr"

gem 'debugger', group: [:development, :test]

group :test, :development do
  gem 'factory_girl'

  gem 'database_cleaner'
  gem 'shoulda'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'simplecov-rcov'
  #para testar o tire
  gem 'fakeweb'

  #gem 'poltergeist'
  gem 'capybara'
  gem 'capybara-webkit'

end
