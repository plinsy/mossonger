class ChatsController < ApplicationController
	before_action :authenticate_user!
  def index
  	redirect_to conversations_path
  end
end