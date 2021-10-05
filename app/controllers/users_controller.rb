class UsersController < ApplicationController
    wrap_parameters :user, include: [:name, :email, :password]
    
    def create
        @user = User.new(user_params)
        if @user.save
            @token = encode_token(user_id: @user.id)
            render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
        else
            render json: { error: 'failed to create user'}, status: :not_acceptable
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
