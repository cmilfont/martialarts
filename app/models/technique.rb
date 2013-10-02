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
  
  def self.simple_search params
    query = params[:q]
    @techniques = []
    @page = params[:page] || 1

    if query.present?
      @techniques = Technique.search :page => @page do
        query do 
          string query
        end
        sort { by :name }
        highlight :name, :description, :options => { :tag => '<strong class="highlight">' }
      end
    end
    @techniques
  end
    
end