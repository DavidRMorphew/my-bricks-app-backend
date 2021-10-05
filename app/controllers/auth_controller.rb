class AuthController < ApplicationController
  wrap_parameters :user, include: [:email, :password]
  
  def create
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      token = encode_token({user_id: @user.id})
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    else
      render json: { message: "Email or Password Invalid" }, status: :unauthorized
    end
  end

  def destroy
    if current_user
      current_user = nil
      render json: { message: "Successfully Logged Out" }, status: :accepted
    else
        render json: { error: "Logout Failed" }, status: :not_acceptable
    end
  end

  def logged_in
    if current_user
      render json: UserSerializer.new(current_user)
    else
      render json: { error: "Login Required" }
    end
  end

  private

  def login_params
      params.require(:user).permit(:email, :password)
  end
end
