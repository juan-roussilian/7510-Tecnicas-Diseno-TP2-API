# rubocop:disable all
ENV['APP_ENV'] = 'test'
require 'rack/test'
require 'rspec/expectations'
require_relative '../../app.rb'
require 'byebug'
require 'faraday'

DB = Configuration.db
Sequel.extension :migration
logger = Configuration.logger
db = Configuration.db
db.loggers << logger
Sequel::Migrator.run(db, 'db/migrations')

BASE_URL = 'http://localhost:3000'.freeze
if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

def get_url_for(route)
  BASE_URL + route
end

After do |_scenario|
  Faraday.post(get_url_for('/reset'))
end
