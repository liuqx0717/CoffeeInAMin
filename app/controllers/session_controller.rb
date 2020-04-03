require 'net/http'


class SessionController < ApplicationController
    def login
        user = User.where(email: params[:email]).take
        if user == nil
            render "session/invalid"
        else
            if user.password == Digest::SHA2.hexdigest(params[:password])
                cookies.signed[:user_id] = user.id
                redirect_to root_path
            else
                render "session/failure"
            end
        end
    end


    def login_google
        id_token = params[:id_token]

        uri = URI("https://oauth2.googleapis.com/tokeninfo?id_token=" + id_token)
        response = Net::HTTP.get_response(uri)
        result = JSON.parse(response.body)

        if result.key?("email")
            email = result["email"]
            user = User.where(email: email).take
            if user == nil
                user = User.new
                user.email = email
                user.name = result["name"]
                user.password = "<Google>"
                user.user_type = 0
                user.save
            end
            cookies.signed[:user_id] = user.id
            redirect_to root_path
        else
            render "session/failure"
        end
    end


    def logout

    end


    def index

    end
end
