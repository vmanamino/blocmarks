class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @user_bookmarks = @user.bookmarks
    @user_bookmarks_topics = get_topics(@user_bookmarks)
    @liked_bookmarks = user_liked_bookmarks(@user)
    @liked_bookmarks_topics = get_topics(@liked_bookmarks)
  end

  def user_liked_bookmarks(user)
    likes = user.likes
    bookmarks = []
    likes.each do |like|
      bookmarks.push(like.bookmark)
    end
    bookmarks
  end

  def get_topics(bookmarks)
    topics = []
    bookmarks.each do |bookmark|
      topics.push(bookmark.topic) unless topics.include?(bookmark.topic)
    end
    topics
  end
end
