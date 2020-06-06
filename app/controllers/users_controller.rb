class UsersController < ApplicationController
  def index
  	users_params = {online: params[:online]}
  	@users = current_user.guests.search(users_params)
  	@onlines = @users[1]
  	respond_to do |format|
  		format.js
  	end
  end
end
