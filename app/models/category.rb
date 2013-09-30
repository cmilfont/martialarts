class Category < ActiveRecord::Base
  
  belongs_to :category

  has_many :categories
  
  validates_presence_of :name
  
end