# encoding: UTF-8
require 'spec_helper'

describe User do

  describe  ".find_for_facebook_oauth" do
    before do
      @nome = "Altamiro Jr"
      @email = "altamiro@gmail.com"
      @facebook_hash = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '123545',
        'extra' => {
          'raw_info' => { 
            'name' => @nome,
            'email' => @email
          }
        },
        'credentials' => {'token' => "toko"}
      })
    end
  
    context "Quando estou deslogado no facebook" do
      describe "Se o usuário existe" do
        before do
          @user  = FactoryGirl.create :user, :email => @email
        end
        it "deveria encontrar um usuario com esse email" do
          User.find_by_email(@email).email.should == @email
        end
      end
    
      describe "Se o usuário não existe" do
        before do
          User.find_by_email(@email).should_not be_present
        end
        it "deveria criar um novo usuário" do
          User.find_for_facebook_oauth(@facebook_hash).should be_present
        end
      end     
    end
  
    context "Quando estou logado no facebook" do
      describe "Se estiver acessando outra conta no facebook" do
        before do
          @user = FactoryGirl.create :user, :email => "altamirojrs@gmail.com"
        end
           
        it "deveria criar um novo usuário" do
          User.find_for_facebook_oauth(@facebook_hash).should_not == @user
        end
      end
    end
  end
end