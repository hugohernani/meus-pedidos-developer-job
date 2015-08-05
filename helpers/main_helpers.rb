module Main
  module Helpers

    def message(text)
      return erb :message, locals => {message: text}
    end
    def error(text)
      halt 400, message(text)
    end
  end
end
