# Tire.configure do
#   wrapper ProxyObject
# end

Tire.configure { logger STDOUT, level: "debug" }

module Martialarts

  class TireConfiguration

    def self.destroy
      ::Tire.index('techniques') do
        delete
      end
      ::Tire.index('tags') do
        delete
      end
    end

    def self.store
      Technique.index.import Technique.all
      Tag.index.import Tag.all
    end

    def self.create

      ::Tire.index('tags') do
        delete
        create \
            settings: {
          index: {
            :analysis => {
              :analyzer=> {
                :index_analyzer=> {
                  :tokenizer=> "standard",
                  :filter=> ["standard", "my_delimiter", "lowercase", "stop", "asciifolding", "porter_stem", "my_edge"]
                },
                :search_analyzer=> {
                  :tokenizer=> "standard",
                  :filter=> ["standard", "lowercase", "stop", "asciifolding", "porter_stem"]
                }
              },
              :filter=> {
                :my_delimiter=> {
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
          },
        },
        mappings: {
          tag: {
            _all: {
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
          }
        }
      end

      ::Tire.index('techniques') do
        delete
        create \
            settings: {
          index: {
            :analysis => {
              :analyzer=> {
                :index_analyzer=> {
                  :tokenizer=> "standard",
                  :filter=> ["standard", "my_delimiter", "lowercase", "stop", "asciifolding", "porter_stem", "my_edge"]
                },
                :search_analyzer=> {
                  :tokenizer=> "standard",
                  :filter=> ["standard", "lowercase", "stop", "asciifolding", "porter_stem"]
                }
              },
              :filter=> {
                :my_delimiter=> {
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
          },
        },
        mappings: {
          technique: {
            _all: {
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
              description: {
                type: "string",
                boost: 1.0,
                index: "analyzed",
                index_analyzer: "index_analyzer",
                search_analyzer: "search_analyzer"
              },
              user_id: {
                type: "integer"
              },
              created_at: {
                type: "date"
              }
            }
          }
        }
      end

    end

  end

end