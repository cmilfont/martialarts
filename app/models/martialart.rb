class Martialart < ActiveRecord::Base
  
  has_many :martialart_techniques
  has_many :techniques, :through => :martialart_techniques
  
  validates_presence_of :name, :description
  
end
