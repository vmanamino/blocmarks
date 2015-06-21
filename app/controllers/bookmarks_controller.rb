class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
    authorize @bookmark
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = current_user.bookmarks.build(params.require(:bookmark).permit(:url)) 
    @bookmark.topic = @topic
    authorize @bookmark
    if @bookmark.save
      redirect_to @topic, notice: 'Your bookmark was saved'
    else
      flash[:error] = 'Your bookmark failed to save, please try again'
      render :new      
    end    
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.destroy
      redirect_to @topic, notice: 'Your bookmark was deleted'
    else
      redirect_to @topic, error: 'Your bookmark failed to delete, please try again'
  end    
  end
  
  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @topic = Topic.find(params[:topic_id])
  end
  
  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
      redirect_to @topic, notice: 'Your bookmark was updated'
    else
      redirec_to @topic, error: 'Your bookmark failed to update, please try again'
    end
  end
end
