require 'spec_helper'

describe UsersController do
    let(:user) { mock_model(User, id: id) }
    let(:id) { 100 }    

    describe "GET #show" do
      it "find an user" do
        User.should_receive(:find).and_return user
        get :show, id: id, format: :json
      end
      
      describe "POST #api" do
        let(:email) { "cmilfont@gmail.com" }
        
         it "cadastra ou informa que já existe" do
            User.should_receive(:create).with(anything).and_return user  
            post :api, email: email, format: :json
         end
                
      end
      
      
    end
    
end