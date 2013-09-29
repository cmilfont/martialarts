require 'spec_helper'

describe TechniquesController do
  
  describe "GET #index" do
        
    it "Should list Techniques" do
      Technique.should_receive(:all).once.and_return [Technique.new]
      get :index, :format => :json
    end
    
  end
  
  describe "GET #show" do
    
    it "Should get Technique by ID" do
      Technique.should_receive(:find).once.and_return Technique.new
      get :show, :id => 1
    end
    
  end

end