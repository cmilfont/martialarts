# encoding: UTF-8
require 'spec_helper'

describe Technique do
  
  describe "Relationships" do
    it { should belong_to :user }
    it { should have_many :martialart_techniques }
    it { should have_many(:martialarts).through :martialart_techniques }
    it { should have_many :videos }
  end
  
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :user }
  end
  
  describe "configure mapping" do
    xit { should be_mapped_by :name }
    xit { should be_mapped_by(:name).with_analyzer 'snowball' }
    xit { should be_mapped_by(:name).with_boost 100 }
    xit { should be_mapped_by :description }
    xit { should be_mapped_by(:description).with_analyzer 'snowball' }
    xit { should be_mapped_by :user_id }
    xit { should be_mapped_by(:user_id).with_type 'integer' }
    xit { should be_mapped_by :created_at }
    xit { should be_mapped_by(:created_at).with_type 'date' }
  end
  
  describe "#simple_search" do
    
    before do 
      @elasticsearch_object ||= '{"took": 1,"timed_out": false,"_shards": {"total": 5,"successful": 5,"failed": 0},"hits": {"total": 0,"max_score": null,"hits": []}}'
      
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => @elasticsearch_object)
      #Technique.should_receive(:find).and_return FactoryGirl.build(:technique)
    end
    
    it "deveria buscar por uma expressão" do      
      @params = ActionController::Parameters.new(technique: { data_inicial: "", data_final: ""}, q: "Juji", page: "1").permit!
      Technique.simple_search(@params).should be_empty
    end
    
  end
  
end
