class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @from = params[:sender]
    @user = User.find_by(email: @from)
    if @user.nil?
      @user = User.new(params.require(:user).permit(:email))
      @user.email = @from
      @user.skip_confirmation!
      @user.save!
    end
    @subject = params[:subject]
    @topic = Topic.find_by(title: @subject)
    if @topic.nil?
      @topic = Topic.new
      @topic.title = @subject
      @topic.user = @user
      @topic.save!
    end

    @url = params['body-plain']
    @bookmark = Bookmark.new
    @bookmark.url = @url
    @bookmark.topic = @topic
    @bookmark.save

    head 200
  end
end
