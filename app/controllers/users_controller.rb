class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @user_bookmarks = @user.bookmarks
    @user_likes = @user.likes
  end
  
  
end
