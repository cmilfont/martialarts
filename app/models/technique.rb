class Technique < ActiveRecord::Base
  def self.search term=""
    results = self.search_es term
    ids = results["hits"]["hits"].map{|hit| hit["_id"] }
    where(id: ids)
  end
  
  include Searchable

  mapping _all: {
    auto_boost: true,
    index_analyzer: "index_analyzer",
    search_analyzer: "search_analyzer"
  },
  properties: {
    created_at: {
      type: "date",
      format: "dateOptionalTime"
    },
    description: {
      type: "string",
      index_analyzer: "index_analyzer",
      search_analyzer: "search_analyzer"
    },
    name: {
      type: "string",
      boost: 10,
      store: true,
      index_analyzer: "index_analyzer",
      search_analyzer: "search_analyzer"
    },
    updated_at: {
      type: "date",
      format: "dateOptionalTime"
    },
    user_id: {
      type: "integer"
    }
  }

  belongs_to :user
  has_many :martialart_techniques, :inverse_of => :technique
  accepts_nested_attributes_for :martialart_techniques
  has_many :martialarts, :through => :martialart_techniques
  has_many :videos
  validates_presence_of :name, :description, :user


  def self.query string_query=""
    j = Jbuilder.encode do |json|
      json.query do
        json.query_string do
          json.query string_query
        end
      end

      json.highlight do
        json.fields do
          json.name do
            json.number_of_fragments 1
          end
        end

        json.pre_tags ["<span class=\"highlight\">"]
        json.post_tags ["</span>"]

      end

    end
    search j
  end

  def self.simple_search params
    query = params[:q]
    @page = params[:page] || 1

    data_inicial = params.require(:technique).fetch(:data_inicial)
    data_final   = params.require(:technique).fetch(:data_final)
    
    data_inicial = DateTime.parse data_inicial if data_inicial.present?
    data_final = DateTime.parse data_final if data_final.present?

    @techniques = Technique.search page: @page, load: true do
      if query.present?
        query do
          string query
        end
      end
      filter :range, created_at: { gte: data_inicial.strftime("%Y-%m-%d") } if data_inicial.present? && data_inicial.is_a?(DateTime)
      filter :range, created_at: { lte: data_final.strftime("%Y-%m-%d") } if data_final.present? && data_final.is_a?(DateTime)
      sort { by :name }
      highlight :name, :description, :options => { :tag => '<strong class="highlight">' }
    end

    @techniques
  end
  
  # def self.intervalo data_inicial, data_final
#    data_inicial = DateTime.parse Time.new(2013, 9, 30, 04).strftime("%Y-%m-%dT%H:%M:%S.000Z")
#    data_final = DateTime.parse Time.new(2013, 9, 30, 17).strftime("%Y-%m-%dT%H:%M:%S.000Z")
    # Technique.search load: true do
    #   filter :range, created_at: { gte: data_inicial.strftime("%Y-%m-%dT%H:%M:%S.000Z") } if data_inicial.present? && data_inicial.is_a?(DateTime)
    #   filter :range, created_at: { lte: data_final.strftime("%Y-%m-%dT%H:%M:%S.000Z") } if data_final.present? && data_final.is_a?(DateTime)
    # end
    #.results.map{|tech| tech.created_at.strftime("%d/%m/%Y %H:%M") }
  # end
    
end