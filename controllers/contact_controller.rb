require 'sinatra/flash'

require_relative 'main_controller'
require_relative '../helpers/contact_helpers'

class ContactController < MainController

  helpers Contact::Helpers
  register Sinatra::Flash

  get_contact = lambda do
    erb :contact
  end

  post_contact = lambda do
    success = send_messages
    success ? flash[:error] = false : flash[:error] = true
    if success
      flash[:notice] = "Obrigado. Você receberá em breve um e-mail conforme sua categoria."
    else
      flash[:notice] = "Error. Algo errado aconteceu. Por favor, tente novamente."
    end
    redirect to('/')
  end

  get '/', &get_contact
  post '/', &post_contact


  # Some IN_APP configuration
  configure :test, :development do
    yaml_config_file = File.join(File.dirname(__FILE__), '../yaml_config.yml')
    environment = YAML.load_file(yaml_config_file)["development"]
    set :email_address => environment["GMAIL"]["EMAIL_ADDRESS"],
    :email_user_name => environment["GMAIL"]["USERNAME"],
    :email_password => environment["GMAIL"]["PASSWORD"],
    :email_domain => environment["GMAIL"]["DOMAIN"]
  end

  configure :production do
    set :email_address => "smtp.sendgrid.net",
    :email_user_name => ENV["SENDGRID_USERNAME"],
    :email_password => ENV["SENDGRID_PASSWORD"],
    :email_domain => "heroku.com"
  end

end
