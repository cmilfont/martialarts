class Tag < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :user
  
  has_many :tag_techniques
  has_many :techniques, through: :tag_techniques
  
  validates_presence_of :name

  def self.simple_search params
    query = params[:q]
    @page = params[:page] || 1
    Tag.search page: @page, load: true do
      if query.present?
        query do
          string query
        end
      end
      sort { by :name }
    end

  end
  
end
