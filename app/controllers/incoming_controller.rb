class IncomingController < ApplicationController
  
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def create
    puts "INCOMING PARAMS HERE #{params}"
    @name = params[:sender]
    @subject = params[:subject]
    @url = params['body-plain']
    
    if @name.nil?
      @name = "viral"
    end
    
    if @subject.nil?
      @subject = 'random musings'
    end
    
    @bookmark = Bookmark.new
    @bookmark.url = @url
    @bookmark.topic = @subject
    @bookmark.save
    head 200
  end
end
