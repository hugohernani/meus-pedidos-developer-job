require 'sinatra/base'
require 'bundler'
Bundler.require

# requirement for datamapper models
require 'data_mapper'

Dir.glob('./{models,helpers,controllers}/*.rb').each do |file|
  require file
end

DataMapper.finalize

ENV['RACK_ENV'] ||= 'development'
# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, ENV['DATABASE_URL'] ||
                           "sqlite:///#{Dir.pwd}/db/#{ENV['RACK_ENV']}.db")

map('/') { run AppController}

# Only for AutoMigration TEST.
# TODO Remove it on last iteration of deployment phase
configure :test, :development do
  map('/test') {
    class TestController < Sinatra::Base
      get '/resetdb' do
        DataMapper.auto_migrate!
        "Finished"
      end
    end
    run TestController
  }
end
