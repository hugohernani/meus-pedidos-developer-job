require 'sinatra/base'
require 'sinatra/flash'
require_relative '../../helpers/contact_helpers'

module Sinatra
  module Contact
    # That is the action app (or route app)
    def self.registered(app)
      app.helpers Helpers # registering the helpers defined above

      app.get '/contact' do
        erb :contact
      end

      app.post '/contact' do
        success = send_messages
        flash[:notice] = "Thank you for your message. We'll be in touch soon."
        redirect to('/contact')
      end

    end
  end
  register Contact
end
