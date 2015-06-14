class IncomingController < ApplicationController
  
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def create
    @user = User.new
    @user.name = params[:sender]
    @topic = Topic.new
    @topic.title = params[:subject]
    @topic.user = @user
    @url = params["body-plain"]
        
    if @user.nil?
      @user = User.new
      @user.name = 'Namenlos'
      @user.email = 'example@mail.com'
    end
    
    if @topic.nil?
      @topic = Topic.new
      @topic.title = "Random"
      @topic.user = @user
    end
    
    @bookmark = Bookmark.new
    @bookmark.url = @url
    @bookmark.topic = @topic
    @bookmark.save
    
    head 200
  end
end