# require File.join(File.dirname(__FILE__), '/spec_helper')
require_relative 'spec_helper'

set :environment, :test

def app
  app = AppController
end

describe app do
  include Rack::Test::Methods

  # Do a root test
  it "should (be_ok|receive status 200) on /" do
    get '/'
    expect(last_response).to be_ok
  end

  # it "should receive index template on /" do
  #   get '/'
  #   expect(last_response.body).to include("Nothing on INDEX yet")
  # end

end

# Using ruby Pony gem
describe "Form" do
  include Rack::Test::Methods

  before(:each) do
    allow(Pony).to receive(:deliver)
  end

  it "sends mail" do
    expect(Pony).to receive(:deliver) do |mail|
      expect(mail.to).to eq [ 'paulo@example.com' ]
      expect(mail.from).to eq [ 'hugo@example.com' ]
      expect(mail.subject).to eq 'Meus Pedidos - avaliação'
      expect(mail.body).to eq 'Olá.'
    end
    Pony.mail(:to => 'paulo@example.com', :from => 'hugo@example.com',
              :subject => 'Meus Pedidos - avaliação', :body => 'Olá.')
  end

  it "requires :to param" do
    expect{ Pony.mail({}) }.to raise_error(ArgumentError)
  end

  it "doesn't require any other param" do
    expect{ Pony.mail(:to => 'joe@example.com') }.to_not raise_error
  end

end
