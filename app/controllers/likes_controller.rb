class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = @bookmark.topic
    like = current_user.likes.build(bookmark: @bookmark)
    authorize like

    if like.save
      redirect_to [@topic, @bookmark], notice: 'You succesfully liked the bookmark'
    else
      redirect_to [@topic, @bookmark], error: 'You failed to like the bookmark'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = @bookmark.topic
    like = current_user.likes.find(params[:id])
    authorize like

    if like.destroy
      redirect_to [@topic, @bookmark], notice: 'You unliked the bookmark'
    else
      redirect_to [@topic, @bookmark], error: 'You did not unlike the bookmark, please try again'
    end
  end
end
