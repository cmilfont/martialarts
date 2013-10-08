module Helpers

  def search_for(word)
    #within 'form#search' do
    #  fill_in 'search_query', with: word
    #  click_button 'Search'
    #end
  end

  def delete_movie_index
    Technique.index.delete
  end

  def create_technique_mocking_elasticsearch params
    id = params[:id]
    elasticsearch_object = "{\"ok\":true,\"_index\":\"techniques\",\"_type\":\"technique\",\"_id\":\"#{id}\",\"_version\":1}"
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => elasticsearch_object)
    technique = FactoryGirl.create :technique, params
    FakeWeb.allow_net_connect = true
    technique
  end

end