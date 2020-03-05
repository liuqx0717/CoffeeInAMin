class SessionController < ApplicationController
    def login
        user = User.where(email: params[:email]).take
        if user == nil
            render "session/invalid"
        else
            if user.password == params[:password]
                cookies[:user_id] = user.id
                render "session/success"
            else
                render "session/failure"
            end
        end
    end

    def logout
        cookies.delete(:user_id)
        redirect_to root_path
    end

    def index

    end
end
