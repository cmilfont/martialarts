# encoding: UTF-8
require 'spec_helper'

describe User do
  
  describe  ".find_for_facebook_oauth" do
    let(:name) { "Christiano Milfont" }
    let(:email) { "cmilfont@gmail.com" }
    let(:facebook_hash) {
      OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '123545',
        'extra' => {
          'raw_info' => { 
            'name' => name,
            'email' => email
          }
        },
        'credentials' => {'token' => "toko"}
      })
    }
    
    context "Quando estou deslogado no facebook" do
      
      describe "Se o usuário existe" do
        before do
          @user = FactoryGirl.create :user, email:email
        end
        it "encontra um usuario com o email informado" do
          User.find_for_facebook_oauth(facebook_hash).should be_present
        end
      end
      
      describe "Se o usuário não existe" do
        before do
          User.find_by_email(email).should_not be_present
        end
        it "cria um novo usuário" do
          User.find_for_facebook_oauth(facebook_hash).should be_present
        end
      end
      
    end
    
  end
  
end