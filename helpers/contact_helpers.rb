require 'pony'

module Contact
  module Helpers

    # Analyse if all the requirements for a specific category are greater than the minimum_level_required
    # Ex. If the category were Front-End, it would probably come values (between 0 and 10)
    # for the following fields: html, css, javascript
    def analyse_requirements(*knowledgments)
      minimum_level_required = 7
      knowledgments.all? do |item|
        item >= minimum_level_required
      end
    end

    # Prepare the body message according to the category: Front-End, Back-End, Mobile, Genérico
    def prepare_body(category)
      filtered_category = category == "Genérico" ? "" : category + " "
      """Obrigado por se candidatar, assim que tivermos uma vaga disponível
      para programador #{filtered_category}entraremos em contato."""
    end

    # Capture params and create mails to be sent according to the values filled by the user.
    def analyse_candidate!(params)
      mails = []
      categories = []
      categories.push("Front-End") if analyse_requirements(params[:html].to_i, params[:css].to_i,
                                      params[:javascript].to_i)
      categories.push("Back-End") if analyse_requirements(params[:python].to_i, params[:django].to_i)
      categories.push("Mobile") if analyse_requirements(params[:ios].to_i, params[:android].to_i)

      unless categories.empty?
        categories.each do |cat|
          mail = {
            :subject => "Obrigado por se candidatar",
            :sender_name => params[:name],
            :sender_email => params[:email],
            :body => prepare_body(cat)
          }
          mails.push mail
        end
      else
        mail = {
          :subject => "Obrigado por se candidatar",
          :sender_name => params[:name],
          :sender_email => params[:email],
          :body => prepare_body("Genérico")
        }
        mails.push mail
      end

      return mails
    end

    # Prepare pony mail and catch if fails
    def send_message(mail)
      begin
        Pony.mail(
          :to => mail[:sender_name] + " <" + mail[:sender_email] + ">",
          :subject => mail[:subject],
          :body => mail[:body]
        )
      rescue => err
        puts "Error on send_message: " + err.to_s
        # TODO Catch it and deal with it
        return false
      end
      return true
    end

    # Prepare default options for Pony and analyse if each prepared mail was sent
    def send_messages
      Pony.options = { # override_options can be used to guarantee that these options will be used.
        :from => "Meus pedidos <hhernanni@gmail.com>", # TODO Change to the real email address
        :via => :smtp,
        :charset => 'UTF-8',
        :via_options => {
          :address              => settings.email_address,
          :port                 => '587',
          :enable_starttls_auto => false,
          :user_name            => settings.email_user_name,
          :password             => settings.email_password,
          :authentication       => :plain,
          :domain               => settings.email_domain
        }
      }
      mails = analyse_candidate!(params)
      result = mails.all? do |mail| # It should return if all messages was sent (true) or not (false)
        send_message(mail) == true
      end
      return result
    end

  end
end
