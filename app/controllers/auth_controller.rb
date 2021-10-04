class AuthController < ApplicationController
  wrap_parameters :user, include: [:email, :password]
  
  def create
      binding.pry
  end

  def destroy
  end

  def logged_in
  end

  private

  def login_params
      params.require(:user).permis(:email, :password)
  end
end
