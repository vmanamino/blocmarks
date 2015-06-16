class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @from = params[:sender]
    @user = User.find_by(email: @from)
    if @user.nil?
      @user = User.new      
      @user.email = @from
      @user.encrypted_password = "$2a$10$5eoHh6M2q4GjGkHClO.NqebWWhS94D8rNj5Ot6CB2qrbn7IrTfkSa"
      @user.skip_confirmation!
      @user.save!(validate: false)
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
    @bookmark.save!

    head 200
  end
end
