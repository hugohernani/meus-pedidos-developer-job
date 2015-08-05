require 'sinatra/base'
require 'bundler'
Bundler.require

# requirement for datamapper models
# require 'data_mapper'

Dir.glob('./{helpers,controllers}/*.rb').each do |file| # removed models directory. Not needing now. TODO
  require file
end

# configure :development, :test do
#   # A Sqlite3 connection to a persistent database
#   DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/#{ENV['RACK_ENV']}.db")
#
# end
#
# configure :production do
#   DataMapper.setup(:default, ENV['DATABASE_URL']) # Heroku ENV variable
# end
# DataMapper.finalize


map('/') { run AppController}
map('/contact') {run ContactController}

# Only for AutoMigration TEST.
# TODO Remove it on last iteration of deployment phase
# configure :test, :development do
#   map('/test') {
#     class TestController < Sinatra::Base
#       get '/resetdb' do
#         DataMapper.auto_migrate!
#         "Finished"
#       end
#     end
#     run TestController
#   }
# end
