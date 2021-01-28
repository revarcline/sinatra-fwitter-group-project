require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['SESSION_KEY']
  end

  get '/' do
    erb :index
  end
end
