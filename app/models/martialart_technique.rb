class MartialartTechnique < ActiveRecord::Base
  
  belongs_to :technique
  belongs_to :martialart
  
  validates_presence_of :technique, :martialart
  
end
