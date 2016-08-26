class UsersController < ApplicationController
  
  skip_filter :authenticate_user!, :authorize_user!
  
  respond_to :json, :html
  
  def show
    @user = User.find params[:id]
    respond_with @user
  end
  
  def api
    @user = User.create email: params[:email], 
                        password: Devise.friendly_token[0,20] 
    respond_with @user
  end
  
end