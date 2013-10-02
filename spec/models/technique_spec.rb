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
  
  describe "#simple_search" do
    
    before do 
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => @elasticsearch_object)
      Technique.should_receive(:find).and_return FactoryGirl.build(:technique)
    end
    
    it "deveria buscar por uma expressão" do
      @params = { q: "Juji", page: 1 }
      Technique.simple_search(@params).should be_empty
    end
    
  end
  
end
