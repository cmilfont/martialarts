martialarts
===========

Pra rodar no Heroku
heroku labs:enable user-env-compile -a martialarts

Verificando os indices no Elasticsearch
heroku addons:open searchbox

Instalar plugin local
sudo bin/plugin -install OlegKunitsyn/elasticsearch-browser
http://localhost:9200/_plugin/browser/?database=techniques&table=technique

Reindexar
Technique.all.each { |technique| technique.update_index }
Technique.index.import Technique.all

Technique.search do
  query do 
    string "name:Baseball"
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


Technique.search do
  query do
    boolean do
      must   { string 'name:juji' }
    end
    
    string "description:judo"
    
  end
  
end