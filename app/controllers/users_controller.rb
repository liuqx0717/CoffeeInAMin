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
end
