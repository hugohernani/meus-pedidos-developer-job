require_relative 'main_controller'
require 'sinatra/flash'
require_relative '../helpers/contact_helpers'

class ContactController < MainController

  helpers Contact::Helpers
  register Sinatra::Flash

  get_contact = lambda do
    erb :contact
  end

  post_contact = lambda do
    success = send_messages
    # flash[:notice] = "Obrigado."
    if success
      redirect ('/')
    else
      redirect to ('/')
    end
  end

  get '/', &get_contact
  post '/', &post_contact


  # Some IN_APP configuration
  configure :test, :development do
    set :email_address => 'smtp.gmail.com',
    :email_user_name => ENV['GMAIL_USERNAME'],
    :email_password => ENV['GMAIL_PASSWORD'],
    :email_domain => 'localhost.localdomain'
  end

  configure :production do
    set :email_address => 'smtp.sendgrid.net',
    :email_user_name => ENV['SENDGRID_USERNAME'],
    :email_password => ENV['SENDGRID_PASSWORD'],
    :email_domain => 'heroku.com'
  end

end
