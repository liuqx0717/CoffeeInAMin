class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def error
    end

    def create
        user = User.find_by email: params[:email]
        if user == nil
            user = User.new
            user.email = params[:email]
            user.name = params[:name]
            user.password = Digest::SHA2.hexdigest(params[:password])
            user.user_type = params[:user_type]
            user.save
            redirect_to root_path
        else
            @msg = "The email has already been registered!"
            # To make render() work, you need to specify "local: true" when
            # using form_with().
            render "users/error"
        end
    end

    def show
        @user = User.find cookies.signed[:user_id]

        if @user.password != "<Google>"
            if @user.user_type == 1
                @shop = Shop.find_by owner_id: @user.id
            else
                @shop = nil
            end
            render "users/show"
        else
            render "users/show-google"
        end
    end

    def update
        user = User.find cookies.signed[:user_id]
        if user.password != "<Google>"
            user.email = params[:email]
            user.name = params[:name]
            user.password = Digest::SHA2.hexdigest(params[:password])
            user.save
        end

        redirect_to "/users/" + @user.id.to_s
    end
end
