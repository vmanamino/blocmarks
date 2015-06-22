class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @topics = Topic.all
    authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = current_user.topics.build(params.require(:topic).permit(:title))
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: 'Topic was saved successfully.'
    else
      flash[:error] = 'There was an error saving your topic.  Please try again.'
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(params.require(:topic).permit(:title))
      flash[:notice] = 'Topic was edited successfully'
      redirect_to @topic
    else
      flash[:error] = 'There was an error saving your topic. Please try again.'
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.destroy
      flash[:notice] = 'Topic was deleted successfully'
      redirect_to topics_path
    else
      flash[:error] = 'There was an error deleting the topic'
      render :index
    end
  end
end
