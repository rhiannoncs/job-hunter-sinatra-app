require 'rack-flash'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  use Rack::Flash
  set :session_secret, "adamantium"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
  	erb :index
  end

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

 end