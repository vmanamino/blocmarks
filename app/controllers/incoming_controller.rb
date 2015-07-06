class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_by(email: params[:sender])
    create_user unless @user
    @topic = Topic.find_by(title: params[:subject])
    create_topic unless @topic
     url = params['body-plain']
    url.strip!
    bookmark = Bookmark.new(url: url, topic: @topic)    
    bookmark.save!
    head 200
  end

  def create_user
    @user = User.new(email: params[:sender], password: params[:sender])
    @user.skip_confirmation!
    @user.save!(validate: false)
  end

  def create_topic
    @topic = Topic.new(title: params[:subject], user: @user)
    @topic.save!
  end
end
