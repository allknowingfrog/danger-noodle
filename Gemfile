# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'

group :development, :test do
  gem 'dotenv'

  gem "rspec"

  gem "guard"
  gem "guard-rspec", require: false
end

gem "thin", "~> 1.8"
