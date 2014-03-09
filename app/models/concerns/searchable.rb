module Searchable
  extend ActiveSupport::Concern

  included do

    attr_accessor :hit

    class_attribute :index
    class_attribute :esclient
    self.index = {}
    self.index[self.name.tableize.to_sym] = { mappings: {}, settings: {} }
    self.index[self.name.tableize.to_sym][:mappings][self.name.tableize.singularize.to_sym] = {}
    self.esclient = Elasticsearch::Client.new host: 'localhost:9200'

    after_update do
      update_document
      true
    end

    after_create do
      create_document
      true
    end

    after_destroy do
      delete_document
      true
    end

    settings_default
  end

  #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/create.rb
  def create_document
    self.esclient.create index: self.class.name.tableize,
                       type: self.class.name.tableize.singularize,
                       id: try(:id),
                       body: attributes
  end

  #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/delete.rb
  def delete_document
    self.esclient.delete index: self.class.name.tableize,
                       type: self.class.name.tableize.singularize,
                       id: try(:id)
  end

  #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/update.rb
  def update_document
    delete_document
    create_document
    #self.esclient.update index: self.class.name.tableize,
    #                     type: self.class.name.tableize.singularize,
    #                     id: try(:id),
    #                     body: {
    #                       doc: changed_attributes
    #                     }
  end

  module ClassMethods

    def settings_default
      settings index: {
        :analysis => {
          :analyzer=> {
            :index_analyzer=> {
              :tokenizer=> "standard",
              :filter=> ["standard", "my_delimiter", "lowercase", "stop", "asciifolding", "my_stemmer", "porter_stem", "my_edge"]
            },
            :search_analyzer=> {
              :tokenizer=> "standard",
              :filter=> ["standard", "lowercase", "stop", "asciifolding", "porter_stem", "my_stemmer"] #"hunspell_ptbr"
            }
          },
          :filter=> {
            #http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/analysis-hunspell-tokenfilter.html
            :hunspell_ptbr => {
              type: "hunspell",
              locale: "pt_BR",
              ignoreCase: true,
              dedup: false
            },
            my_stemmer: {
              type: "snowball",
              name: "Brazilian"
            },
            :my_delimiter => {
              :type=> "word_delimiter",
              :generate_word_parts=> true,
              :catenate_words=> true,
              :catenate_numbers=> true,
              :catenate_all=> true,
              :split_on_case_change=> true,
              :preserve_original=> true,
              :split_on_numerics=> true,
              :stem_english_possessive=> true
            },
            my_edge: {
              type: 'edgeNGram', #1 to 10 letters, from the start
              min_gram: 1,
              max_gram: 10,
              side: 'front'
            }
          }
        }
      }
    end

    #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/bulk.rb
    def create_documents
      documents = self.name.constantize.send(:all).map do |document|
        {
          index:  {
            _index: self.name.tableize,
            _type: self.name.tableize.singularize,
            _id: document.try(:id),
            data: document.attributes
          }
        }
      end
      self.esclient.bulk body: documents if documents.present?
    end

    #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/indices/delete.rb
    def destroy_index
      self.esclient.indices.delete index: self.name.tableize
    end

    #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/indices/create.rb
    def create_index
      self.esclient.indices.create index: self.name.tableize, body: self.index[self.name.tableize.to_sym]
    end

    def mapping conf={}
      self.index[self.name.tableize.to_sym][:mappings][self.name.tableize.singularize.to_sym] = {
        #_source: { enabled: false }
      }.merge(conf)
    end

    def settings conf
      self.index[self.name.tableize.to_sym][:settings] = conf
    end

    #https://github.com/elasticsearch/elasticsearch-ruby/blob/master/elasticsearch-api/lib/elasticsearch/api/actions/search.rb
    def search q=nil
      results = self.esclient.search index: self.name.tableize, body: q, source: false

      ids = results["hits"]["hits"].map do |hit|
        hit["_id"]
      end

      self.name.constantize.send(:find, ids).zip(results["hits"]["hits"]).map do |item|
        model = item[0]
        hit   = item[1]
        model.hit = hit
        model
      end
    end

  end

end