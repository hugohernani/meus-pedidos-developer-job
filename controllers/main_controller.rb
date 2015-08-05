require_relative '../lib/asset-handler'

class MainController < Sinatra::Base
  set :views, File.expand_path('../../templates', __FILE__)

  use Rack::Session::Cookie,
    :key => "rack.session",
    :path => "/",
    :secret => "TODO_that is only for test"

  helpers Main::Helpers
  use AssetHandler

end
