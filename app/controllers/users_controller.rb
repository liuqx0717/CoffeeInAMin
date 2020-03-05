class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        logger = Rails.logger
        logger.info "*************************************************"
        logger.info "create"
        logger.info params[:email]
        @user = User.new
        @user.email = params[:email]
        @user.name = params[:name]
        @user.password = params[:password]
        @user.user_type = params[:user_type]
        @user.save
        redirect_to root_path
    end


    def update
        @user = User.find cookie['user_id']
        @user.update(email: params[:email], name: params[:name], password: params[:password])

        @user.save()

        redirect_to root_path
    end
end
