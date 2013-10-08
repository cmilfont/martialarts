require 'spec_helper'

describe Tag do

  describe "Relationships" do
    it { should have_many :tag_techniques }
    it { should have_many(:techniques).through :tag_techniques }
    it { should belong_to :user }
  end
  
  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "#simple_search" do


    before do
      @elasticsearch_object ||= '{"took": 1,"timed_out": false,"_shards": {"total": 5,"successful": 5,"failed": 0},"hits": {"total": 0,"max_score": null,"hits": []}}'
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => @elasticsearch_object)
    end

    it "Deveria buscar por uma expressão" do
      @params = ActionController::Parameters.new(tag: {}, q: "choke", page: "1").permit!
      Tag.simple_search(@params).should be_empty
    end

  end

end
