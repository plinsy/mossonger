class PagesController < ApplicationController
  def index
    redirect_to chats_path if user_signed_in?
  end

  def rooms
  end

  def features
  end

  def privacy
  end

  def for_developers
  end

  def about
  end
end
