require_relative 'main_controller'

class AppController < MainController

  init_app = lambda do
    erb :index
  end

  get '/', &init_app

end
