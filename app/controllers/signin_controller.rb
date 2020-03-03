class SigninController < ApplicationController
    def index
        cookies[:token] = '123456'
        redirect_to root_path
    end
end
