class UsersController < ApplicationController
    wrap_parameters :user, include: [:name, :email, :password]
    
    def create
        @user = User.new(user_params)
        if @user.save
            # register user with token
            render json: UserSerializer.new(@user), status: :created
        else
            render json: { error: 'failed to create user'}, status: :not_acceptable
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
