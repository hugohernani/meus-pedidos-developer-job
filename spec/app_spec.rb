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

end
