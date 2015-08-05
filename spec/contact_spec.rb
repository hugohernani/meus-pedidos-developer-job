require File.join(File.dirname(__FILE__), '/spec_helper')
require_relative '../helpers/contact_helpers'

set :environment, :test

def app
  app = ContactController # redirect to '/contact'
end

describe app do
  include Rack::Test::Methods

  it "should (be_ok|receive status 200) on /contact" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should contain html, css, javascript, django, python, ios, android on /contact" do
    get '/'
    expect(last_response.body).to include("html","css","javascript","django","python","ios","android")
  end

  it "should contain a 'warning' message if at least one of the messages wasn't sent" do
    params = {:name => "Hugo Hernani Ferreira da Silva", :email => "hhernanni@gmail.com"}
    post '/', params
    get '/' # Redirected
    expect(last_response.body).to include("Error. Algo errado aconteceu. Por favor, tente novamente.")
  end


end

describe "ContactController Helpers" do
  include Rack::Test::Methods


end

# # Using ruby Pony gem
# describe "Form" do
#   include Rack::Test::Methods
#
#   before(:each) do
#     allow(Pony).to receive(:deliver)
#   end
#
#   it "sends mail" do
#     expect(Pony).to receive(:deliver) do |mail|
#       expect(mail.to).to eq [ 'paulo@example.com' ]
#       expect(mail.from).to eq [ 'hugo@example.com' ]
#       expect(mail.subject).to eq 'Meus Pedidos - avaliação'
#       expect(mail.body).to eq 'Olá.'
#     end
#     Pony.mail(:to => 'paulo@example.com', :from => 'hugo@example.com',
#               :subject => 'Meus Pedidos - avaliação', :body => 'Olá.')
#   end
#
#   it "requires :to param" do
#     expect{ Pony.mail({}) }.to raise_error(ArgumentError)
#   end
#
#   it "doesn't require any other param" do
#     expect{ Pony.mail(:to => 'joe@example.com') }.to_not raise_error
#   end
#
# end
