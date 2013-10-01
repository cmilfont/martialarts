class Technique < ActiveRecord::Base
  
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  mapping do
    indexes :name,        :analyzer => 'snowball', :boost => 100
    indexes :description, :analyzer => 'snowball'
    indexes :user_id
  end
  
  belongs_to :user
  
  has_many :martialart_techniques, :inverse_of => :technique
  accepts_nested_attributes_for :martialart_techniques
  
  has_many :martialarts, :through => :martialart_techniques
  
  has_many :videos
  
  validates_presence_of :name, :description, :user
    
end