class TechniquesController < ApplicationController
      
  respond_to :json, :html
  
  def index
    @techniques = Technique.all
    respond_with @techniques
  end
  
  def show
    @technique = Technique.find params[:id]
    respond_with @technique
  end
  
end