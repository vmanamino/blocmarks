class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])    
  end

  def new
    @topic = Topic.new
    # authorize @topic
  end
  
  def create
    @topic = Topic.new(params.require(:topic).permit(:title))
    # authorize @topic
   
    if @topic.save
      redirect_to @topic, notice: 'Topic was saved successfully.'
    else
      flash[:error] = 'There was an error saving your topic.  Please try again.'
      render :new
    end
  end

  def edit
  end
end
