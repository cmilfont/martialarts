martialarts
===========

Pra rodar no Heroku
heroku labs:enable user-env-compile -a martialarts

Verificando os indices no Elasticsearch
heroku addons:open searchbox

Instalar plugin local
sudo bin/plugin -install OlegKunitsyn/elasticsearch-browser
http://localhost:9200/_plugin/browser/?database=techniques&table=technique


== INDEX ==
Deletar um index na mão
curl -X DELETE http://localhost:9200/techniques

Criar um index
curl -XPUT http://localhost:9200/techniques/ -d '
{
  "settings": {
    "analysis": {
      "analyzer": {
        "index_analyzer": {
          "tokenizer": "standard",
          "filter": ["standard", "my_delimiter", "lowercase", "stop", "asciifolding", "porter_stem"]
        },
        "search_analyzer": {
          "tokenizer": "standard",
          "filter": ["standard", "lowercase", "stop", "asciifolding", "porter_stem"]
        }
      },
      "filter": {
        "my_delimiter": {
          "type": "word_delimiter",
          "generate_word_parts": true,                
          "catenate_words": true,
          "catenate_numbers": true,
          "catenate_all": true,
          "split_on_case_change": true,
          "preserve_original": true,
          "split_on_numerics": true,
          "stem_english_possessive": true
        }
      }
    }
  }
}'

== MAPPING ==
curl -XPUT 'http://localhost:9200/techniques/technique/_mapping' -d '
{
    "technique": {
      "_all" : {"enabled" : true, "index_analyzer": "index_analyzer", "search_analyzer": "search_analyzer"},
      "properties": {
        "name": {
          "type": "string",
          "boost": 10.0,
          "index": "analyzed",
          "index_analyzer": "index_analyzer",
          "search_analyzer": "search_analyzer",
          "store": "yes"
        },
        "description": {
          "type": "string",
          "boost": 1.0,
          "index": "analyzed",
          "index_analyzer": "index_analyzer",
          "search_analyzer": "search_analyzer"
        },
        "user_id": {
          "type": "integer"
        },
        "created_at": {
          "type": "date"
        }
      }
    }
}'

Reindexar
Technique.all.each { |technique| technique.update_index }

reload!
Technique.index.delete
Technique.index.import Technique.all
Technique.search do
  query do 
    string "name:leão"
  end
  sort { by :name }
end

Technique.search do
  query do 
    string "name:leao"
  end
  sort { by :name }
end

Technique.search do
  query do 
    string "description:anaconda"
  end
  sort { by :name }
end

Technique.search do
  query do 
    string "name:Baseball AND description:juji"
  end
  sort { by :name }
end

# must é o AND
# should é o OR
# must_not é o AND NOT
Technique.search do
  query do
    boolean do
      must   { string 'name:Baseball' }
      must   { string 'name:juji' }
    end
  end
end

t = Technique.search do
  query do 
    match 'name',  'baseball'
    match 'description', 'juji'
  end
  sort { by :name }
  highlight :name, :description, :options => { :tag => '<strong class="highlight">' }
end

t.results.each do |technique|
  puts "Name: #{ technique.name }; Highlighted: #{technique.highlight.name}"
end