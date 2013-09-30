require 'spec_helper'

describe TechniquesController do
  
  describe "GET #index" do
        
    it "Should list Techniques" do
      Technique.stub_chain(:all, :order).and_return [Technique.new]
      Technique.should_receive(:all).once
      get :index
    end
    
  end
  
  describe "GET #show" do
    
    it "Should get Technique by ID" do
      Technique.should_receive(:find).once.and_return Technique.new
      get :show, :id => 1
    end
    
  end

end