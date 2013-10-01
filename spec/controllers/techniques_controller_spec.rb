# encoding: UTF-8
require 'spec_helper'

describe TechniquesController do
  
  describe "GET #index" do
        
    it "Should list Techniques" do
      Technique.stub_chain(:all, :order, :paginate).and_return [Technique.new]
      Technique.should_receive(:all).once
      get :index
    end
    
  end
  
  describe "GET #show" do
    
    it "Should get Technique by ID" do
      @id = "1"
      Technique.should_receive(:find).with(@id).once.and_return Technique.new
      get :show, :id => @id
    end
    
  end
  
  context "Quando exige usuário logado" do
    
    before do
      @user = FactoryGirl.create :user, :admin => true
      sign_in @user
    end
    
    describe "GET #new" do
      it "Deveria obter uma nova técnica" do
        @technique = mock_model Technique
        Technique.should_receive(:new).once.and_return @technique
        get :new
      end
    end

    describe "GET #edit" do
      it "Deveria editar uma técnica" do
        @id = "1"
        Technique.should_receive(:find).with(@id).once.and_return Technique.new
        get :edit, :id => @id
      end
    end

    describe "POST #create" do
      it "Deveria cadastrar uma técnica" do
        @params = { "name" => "Bjj", "description" => "Mock" }
        @technique = mock_model Technique
        @technique.should_receive(:user=).with(anything).once
        @technique.should_receive(:save).once
        Technique.should_receive(:new).with(@params).and_return @technique
        post :create, :technique => @params
      end
    end

    describe "PUT #update" do
      it "Deveria atualizar uma técnica" do
        @id = "1"
        @params = { "name" => "Bjj", "description" => "Mock" }
        @technique = mock_model Technique
        @technique.should_receive(:update).with(@params).once
        Technique.should_receive(:find).with(@id).and_return @technique
        put :update, :id => @id, :technique => @params
      end
    end
    
  end

end