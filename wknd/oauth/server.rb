require 'sinatra'
require 'rest-client'
require 'json'



get '/' do
  erb :index, :locals => {:client_id => CLIENT_ID}
end

get '/callback' do
  # get temporary GitHub code...
  session_code = 'a13f5d8874a4056bb629ab2bd747b30bf49b4e4e'

  # ... and POST it back to GitHub
  result = RestClient.post('https://github.com/login/oauth/access_token',
  {:client_id => CLIENT_ID,
    :client_secret => CLIENT_SECRET,
    :code => session_code},
    :accept => :json)

    # extract the token and granted scopes
    access_token = JSON.parse(result)['access_token']
  end
