class ProfileController < ApplicationController
  def index
    @user = User.find cookie['user_id']
    render 'profile/profile'
  end
end
