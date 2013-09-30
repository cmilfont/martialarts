class Technique < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :martialart_techniques, :inverse_of => :technique
  accepts_nested_attributes_for :martialart_techniques
  
  has_many :martialarts, :through => :martialart_techniques
  
  has_many :videos
  
  validates_presence_of :name, :description, :user
    
end