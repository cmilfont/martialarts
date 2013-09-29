class Technique < ActiveRecord::Base
  
  belongs_to :user
  
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :martialarts
  
  has_many :videos
  
  validates_presence_of :name, :description
    
end
