require 'spec_helper'

describe MartialartsController do

  before do
    @user = FactoryGirl.create :user, :admin => true
    sign_in @user
  end

  describe "GET #index" do 
    it "Should list Martial Arts" do
      Martialart.stub_chain(:order).and_return [Martialart.new]
      Martialart.should_receive(:order).with(:name).once
      get :index
    end
  end
  
  describe "GET #show" do
    it "Should get Technique by ID" do
      Martialart.should_receive(:find).once.and_return Martialart.new
      get :show, :id => 1
    end
  end
  
  describe "GET #new" do
    it "Should a new Technique" do
      @martialart = mock_model Martialart
      Martialart.should_receive(:new).once.and_return @martialart
      get :new
    end
  end
  
  describe "GET #edit" do
    it "Should a new Technique" do
      Martialart.should_receive(:find).once.and_return Martialart.new
      get :edit, :id => 1
    end
  end
  
  describe "POST #create" do
    it "Should create a Technique" do
      @martialart = mock_model Martialart
      Martialart.should_receive(:create).with(anything).and_return @martialart
      post :create, :martialart => { :name => "Teste", :description => "Teste" }
    end    
  end

  describe "PUT #update" do
    it "Should update a Technique" do
      @martialart = mock_model Martialart
      @martialart.should_receive(:update).with(anything)
      Martialart.should_receive(:find).once.and_return @martialart
      put :update, :id => 1, :martialart => { :name => "Teste", :description => "Teste" }
    end
  end

  describe "DELETE #destroy" do
    it "Should update a Technique" do
      @martialart = mock_model Martialart
      @martialart.should_receive(:destroy).once
      Martialart.should_receive(:find).once.and_return @martialart
      delete :destroy, :id => 1
    end
  end


end