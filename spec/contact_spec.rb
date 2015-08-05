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

  class TestHelper
    include Contact::Helpers
  end

  let(:helpers) { TestHelper.new }

  def default_message(cat)
    "Obrigado por se candidatar, assim que tivermos uma vaga disponível"\
    " para programador #{cat}entraremos em contato."
  end

  context "Not Pony context" do

    context "Email template" do

      shared_examples "email_template" do |cat|
        it "should include #{cat} on the default message" do
          expect(helpers.prepare_body(cat)).to eq default_message("#{cat} ")
        end
      end

      include_examples "email_template", "Front-End"
      include_examples "email_template", "Back-end"
      include_examples "email_template", "Mobile"

      it "shouldn't include any category (empty string) if Genérico is passed to prepare_body helper" do
        expect(helpers.prepare_body("Genérico")).to eq default_message("")
      end
    end

    context "Analysing main point of business logic" do
      it "should return true when passed a list of Strings (arguments) greater than or equal to 7" do
        # 7, 8, 9 it will represent how the user know about each field.
        # Ex. html: 7; css: 8, javascript: 7
        knowledgments = {:html => "7", :css => "8", :javascript => "7"}
        expect(helpers.analyse_requirements(
              knowledgments[:html], knowledgments[:css], knowledgments[:javascript])).to be true
      end

      it "should return false when passed a list of Strings (arguments) smaller than 7" do
        # 7, 8, 9 it will represent how the user know about each field.
        # Ex. html: 7; css: 8, javascript: 7
        knowledgments = {:html => "3", :css => "4", :javascript => "6"}
        expect(helpers.analyse_requirements(
              knowledgments[:html], knowledgments[:css], knowledgments[:javascript])).to be false
      end

      it "should return equally mails list when passed params. Simulation" do
        params = { :name => "Hugo Hernani Ferreira da Silva", :email => "hhernanni@gmail.com",
          :html => "7", :css => "5", :javascript => "6", :python => "7", :django => "7", :ios => "8",
          :android => "9"
        } # approved for back-end and mobile jobs

        mail_1 = {
          :subject => "Obrigado por se candidatar", :sender_name => params[:name],
          :sender_email => params[:email],
          # reusing default_message for convenience
          :body => default_message("Back-End ")
        }

        mail_2 = {
          :subject => "Obrigado por se candidatar", :sender_name => params[:name],
          :sender_email => params[:email],
          # reusing default_message for convenience
          :body => default_message("Mobile ")
        }

        mails = [mail_1, mail_2] # Those two template mails should be used.

        expect(helpers.analyse_candidate!(params)).to eq mails
        expect(helpers.analyse_candidate!(params).length).to eq 2 # 2 mails for the params passed
      end

      it "should return equally mails list when passed params. Simulation. Generic template" do
        params = { :name => "Hugo Hernani Ferreira da Silva", :email => "hhernanni@gmail.com",
          :html => "5", :css => "5", :javascript => "4", :python => "3", :django => "4", :ios => "6",
          :android => "5"
        } # Failed in all jobs requirements

        mail_1 = {
          :subject => "Obrigado por se candidatar", :sender_name => params[:name],
          :sender_email => params[:email],
          # reusing default_message for convenience
          # Genérico on the test method. Equivalent to self helpers.prepare_body("Genérico")
          :body => default_message("")
        }
        mails = [mail_1]

        expect(helpers.analyse_candidate!(params)).to eq mails
        expect(helpers.analyse_candidate!(params).length).to eq 1 # 1 mail for the params passed
      end

    end
  end

  context "Pony context" do

    def prepare_mail
      mail = {
        :sender_name => "Hugo Hernani",
        :sender_email => "hhernanni@gmail.com",
        :subject => "Obrigado por se candidatar",
        :body => default_message("Front-End ")
      }
    end

    context "Pony simulation" do
      before(:each) do
        allow(Pony).to receive(:deliver)
      end

      it "should return 'message_sent' if succeded sending the message " do
        mail = prepare_mail

        expect(Pony).to receive(:deliver) do |mail|
          expect(mail.to).to eq [ 'hhernanni@gmail.com' ]
          expect(mail.from).to eq [ 'hhernanni@gmail.com' ]
          expect(mail.subject).to eq 'Obrigado por se candidatar'
          expect(mail.body).to eq default_message("Front-End ")
        end

        expect(helpers.send_message(mail)).to eq 'message_sent'
      end
    end

    # It will only be possible NOT TO return 'error' on real proccess due to authentication made through
    # email servers as google, which uses HELO methodology...
    # That is why this test SHOULD return 'error'. It was caught and dealt to do that.
    # For a simulation on returning what is expected on a 'authentified Pony' see the test above.
    it "should return 'error' if an error occured while trying to send" do
      mail = prepare_mail
      expect(helpers.send_message(mail)).to eq 'error'
    end

  end

end
