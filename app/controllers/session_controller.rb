require 'net/http'

class SessionController < ApplicationController
    def login
        user = User.where(email: params[:email]).take
        if user == nil
            render "session/invalid"
        else
            if user.password == Digest::SHA2.hexdigest(params[:password])
                cookies.signed[:user_id] = user.id
                render "session/success"
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

        redirect_to "/" + result["iss"]
    end

    def logout
        cookies.delete(:user_id)
        redirect_to root_path
    end

    def index

    end
end
