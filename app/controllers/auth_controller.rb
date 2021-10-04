class AuthController < ApplicationController
  wrap_parameters :user, include: [:email, :password]
  
  def create
    @user = User.find_by(email: login_params[:email])
      binding.pry
  end

  def destroy
  end

  def logged_in
  end

  private

  def login_params
      params.require(:user).permit(:email, :password)
  end
end
