class Tag < ActiveRecord::Base

  include Searchable

  mapping _all: {
      enabled: true,
      index_analyzer: "index_analyzer",
      search_analyzer: "search_analyzer"
    },
    properties: {
      name: {
        type: 'string',
        boost: 10.0,
        index: "analyzed",
        index_analyzer: "index_analyzer",
        search_analyzer: "search_analyzer",
        store: "yes"
      },
      user_id: {
        type: "integer"
      }
    }

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
