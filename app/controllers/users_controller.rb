class UsersController < ApplicationController
    wrap_parameters :user, include: [:name, :email, :password]
    
    def create

    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
