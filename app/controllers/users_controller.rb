class UsersController < ApplicationController
    def create
        @user = User.new
        @user.email = params[:email]
        @user.name = params[:name]
        @user.password = params[:password]
        @user.user_type = params[:user_type]
        @user.save
        redirect_to root_path
    end

    def login
        user = User.where(email: params[:email]).take
        if user == nil
            render "signin/invalid"
        else
            if user.password == params[:password]
                cookies[:user_id] = user.id
                render "signin/success"
            else
                render "signin/failure"
            end
        end
    end
end