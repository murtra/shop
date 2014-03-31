class UsersController < ApplicationController  
  before_action :only_not_authenticated_user!
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save    
      login_user(@user)  
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end 
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end
end
