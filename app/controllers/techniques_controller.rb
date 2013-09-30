class TechniquesController < ApplicationController
  
  before_action :set_technique, :only => [:show, :edit, :update, :destroy]
  
  before_filter :authenticate_user!, :only => [:new, :create]
  
  respond_to :json, :html
  
  def index
    @techniques = Technique.all.order(:name)
    respond_with @techniques
  end
  
  def show
    respond_with @technique
  end
  
  def new
    @technique = Technique.new
  end
  
  def edit
  end
  
  def create
#    params.require(:martialart).permit(:name, :description)
    @technique = Technique.new params.require(:technique)
    @technique.user = current_user
    @technique.save
    respond_with @technique
  end
  
  private
  def set_technique
    @technique = Technique.find params[:id]
  end
  
end