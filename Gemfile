source "https://rubygems.org"

ruby File.read(".ruby-version").chomp

gem "amygdala", "~> 0.1.0"

group :development, :test do
  gem "dotenv"

  gem "lefthook"
  gem "standard"

  gem "rspec"

  gem "guard"
  gem "guard-rspec", require: false
end

gem "thin", "~> 1.8"
