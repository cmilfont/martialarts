class Video < ActiveRecord::Base
  
  belongs_to :technique
  
  validates_presence_of :link
  
end
