# encoding: UTF-8
require 'spec_helper'

describe VideosController do
  
  before do
    @technique_id = "1001"
    @technique = mock_model Technique
    Technique.should_receive(:find).with(@technique_id).once.and_return @technique
  end

  describe "POST #create" do
    it "Deveria adicionar um video a uma técnica" do
      @video = mock_model Video
      Video.should_receive(:create).and_return @video
      post :create, :technique_id => @technique_id, :link => "http://www.youtube.com/embed/IIWyg-5e87w?html5=1"
    end
  end

  describe "DELETE #destroy" do
    
    before do
      @id = "189"
      @video = mock_model Video
      @video.should_receive(:destroy).once
      @technique.stub_chain(:videos, :find).and_return @video      
    end
    
    it "Deveria remover o vídeo" do
      delete :destroy, :technique_id => @technique_id, :id => @id
    end
    
  end
  
end