class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @user_bookmarks = @user.bookmarks
    @liked_bookmarks = likes
  end
  
  
end
