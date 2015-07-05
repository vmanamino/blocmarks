class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
#   def should_generate_new_friendly_id?
#      new_record?
#   end

end
