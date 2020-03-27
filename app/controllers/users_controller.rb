class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new
        @user.email = params[:email]
        @user.name = params[:name]
        @user.password = Digest::SHA2.hexdigest(params[:password])
        @user.user_type = params[:user_type]
        @user.save

        redirect_to root_path
    end

    def show
        @user = User.find cookies.signed[:user_id]

        if @user.user_type == 1
            @shop = Shop.find_by owner_id: @user.id
        else
            @shop = nil
        end


    end

    def update
        @user = User.find cookies.signed[:user_id]
        @user.email = params[:email]
        @user.name = params[:name]
        @user.password = Digest::SHA2.hexdigest(params[:password])
        @user.save

        redirect_to "/users/" + @user.id.to_s
    end
end
