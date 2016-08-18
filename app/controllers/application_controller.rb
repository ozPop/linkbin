require './config/environments'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    "Hello World"
  end

end