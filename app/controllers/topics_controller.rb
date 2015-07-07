class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @topics = Topic.all
    authorize @topics
  end

  def show
    @topic = Topic.friendly.find(params[:id])
    @bookmarks = @topic.bookmarks
    if request.path != topic_path(@topic) # rubocop:disable Style/GuardClause
      redirect_to @topic, status: :moved_permanently
    end
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
    @topic = Topic.friendly.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.friendly.find(params[:id])
    @topic.slug = nil
    authorize @topic
    if @topic.update_attributes(params.require(:topic).permit(:title))
      redirect_to @topic, notice: 'Topic was edited successfully'
    else
      flash[:error] = 'There was an error saving your topic. Please try again.'
      render :edit
    end
  end

  def destroy
    @topic = Topic.friendly.find(params[:id])
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
