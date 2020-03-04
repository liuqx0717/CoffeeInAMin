class UsersController < ApplicationController
    def create
        @user = User.new
        @user.email = params[:email]
        @user.name = params[:name]
        @user.password = params[:password]
        @user.type = params[:type]

        @user.save()

        redirect_to root_path
    end

    def update
        @user = User.find cookie['user_id']
        @user.update(email: params[:email], name: params[:name], password: params[:password])

        @user.save()

        redirect_to root_path
    end
end
