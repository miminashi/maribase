require 'sinatra/base'
require 'sinatra/r18n'
require 'haml'

module Katsusika
  class Web < Sinatra::Base
    register Sinatra::R18n

    get '/' do
      haml :index
    end
  end
end
