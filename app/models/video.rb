class Video < ActiveRecord::Base
  
  belongs_to :technique
  belongs_to :user
  
  validates_presence_of :link, :technique, :user
  
end
