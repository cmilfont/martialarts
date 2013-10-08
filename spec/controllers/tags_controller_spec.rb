require 'spec_helper'

describe TagsController do

  describe "GET #index" do

    before do
      Tag.should_receive(:simple_search).once.and_return @tags
    end

    it "Deveria buscar por parte do nome da tag" do
      get :index, q: "choke", format: :json
    end

  end

end
