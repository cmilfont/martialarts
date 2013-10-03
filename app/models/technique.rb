class Technique < ActiveRecord::Base
  
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  # curl -XPOST localhost:9200/techniques -d '{
  #     "settings" : {
  #         "number_of_shards" : 1,
  #         "number_of_replicas": 1,
  #         "analysis": {
  #           "filter" : {
  #             "my_edge": {
  #               "type" : "edgeNGram",
  #               "max_gram": 10
  #             }
  #           },
  #           "analyzer" :{
  #             "brazilian_snowball" : {
  #               "tokenizer"  : "standard",                 
  #                "filter"    : ["standard", "lowercase", "my_edge", "asciifolding"],
  #                "language"  : "Brazilian",
  #                "type"      : "snowball"
  #             }
  #           }
  #         }
  #     },
  #     "mappings" : {
  #         "technique" : {
  #             "_source" : { "enabled" : false },
  #             "properties" : {
  #                 "name" : { "type" : "string", "analyzer" : "brazilian_snowball" }
  #             }
  #         }
  #     }
  # }'
  
  # settings :number_of_shards => 1,
  #          :number_of_replicas => 1,
  #          :analysis => {
  #            :filter => {
  #              :my_edge  => {
  #                "type"     => "edgeNGram",
  #                "max_gram" => 5,
  #                "min_gram" => 1 
  #              }
  #            },
  #            :analyzer => {
  #              :brazilian_snowball => {
  #                "tokenizer"  => "standard",                 
  #                "filter"       => ["standard", "lowercase", "my_edge", 'asciifolding'],
  #                "language"     => "Brazilian",
  #                "type"         => "snowball" }
  #            }
  #          }
           
   mapping do
     indexes :name, :type => 'string', :analyzer => 'snowball', :boost => 100
     indexes :description, :analyzer => 'snowball'
     indexes :user_id,     :type => 'integer'
     indexes :created_at,  :type => 'date'
   end
  
  belongs_to :user
  has_many :martialart_techniques, :inverse_of => :technique
  accepts_nested_attributes_for :martialart_techniques
  has_many :martialarts, :through => :martialart_techniques
  has_many :videos
  validates_presence_of :name, :description, :user
  
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