require 'sinatra'
require 'rack/test'
require 'rspec'

# requirement for datamapper models
require 'data_mapper'

Dir.glob('./{models,modules,helpers,controllers}/*.rb').each do |file|
  require file
end

ENV['RACK_ENV'] ||= 'development'
# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, ENV['DATABASE_URL'] ||
                           "sqlite:///#{Dir.pwd}/db/#{ENV['RACK_ENV']}.db")

# set test environment
configure :test do config
  set :run, false
  set :raise_errors, true
  set :logging, false
  config.before(:each) { DataMapper.auto_migrate! }
end


# For testing models
# reset the database before each test to make sure our tests don't influence one another
# Rspec.configure do |config|
#   config.before(:each) { DataMapper.auto_migrate! }
# end
