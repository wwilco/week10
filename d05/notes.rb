Rails.application
  get '/login' => 'sessions#new'
  post '/session' => "session#create"
  delete '/session' => 'destroy#'

  get '/secret' => 'secret#new'




config/secrets.yml

uncomment out bcrypt
run bundle install

~rails generate model User usernmae:text password_digest:text

#models/user.rb
class User < ActiveRecord::Base
  validates_uniqueness_of :username
  has_secure_password
end
#run migration  ~rake db:migrate

# session controller:
class SessionController < ApplicationController
  def create #with username
    user = USer.find_by(username: params[:usernmae])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/secret'
    else
      render :new
    end
  end

  def create #without username
    if params[:password] == Rails. appication.secrets.secret_password
      session[:valid_user] = true
      redirect_to '/secret'
    else
      render :new
    end
  end
  def destroy
    reset_session
    redirect_to '/login'
  end
end

# secret controller
class SecretController < ApplicationController
  def show #with username
    @user = User.dinf_by(id: session[:user_id])
    if @user
      render :show
    else
      redirect_to '/login'
    end
  end

  def show #without username
    valid_user = session[:valid_user]
    if valid_user
      fender :show
    else
      redirect_to '/login'
    end
  end
end
