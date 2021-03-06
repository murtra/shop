class SessionsController < ApplicationController 
  before_action :only_not_authenticated_user!, except: :destroy 
    
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login_user(user)  
      redirect_to root_url, :notice => I18n.t("generic.logged_in") # "Logged in!"
    else
      flash.now.alert = I18n.t("generic.invalid_credentials") # "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => I18n.t("generic.logged_out")
  end 

end
