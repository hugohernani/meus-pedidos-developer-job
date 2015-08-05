require_relative '../lib/sinatra/contact'

class AppController < MainController

  register Sinatra::Flash

  init_app = lambda do
    erb :index
  end

  get '/', &init_app

end
