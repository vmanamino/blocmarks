class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(params.require(:bookmark).permit(:url)) 
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
      flash[:error] = 'Your bookmark failed to delete, please try again'
      render :show
    end    
  end
  
  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end
  
  def update
    
  end
end
