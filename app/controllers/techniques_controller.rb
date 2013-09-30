class TechniquesController < ApplicationController
  
  before_action :set_technique, :only => [:show, :edit, :update, :destroy]
  
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update]
  
  respond_to :json, :html
  
  def index
    @techniques = Technique.all.order(:name).paginate :page => params[:page] || 1, :per_page => 10
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
  
  def update
    @technique.update params.require(:technique)
    respond_with @technique
  end
  
  private
  def set_technique
    @technique = Technique.find params[:id]
  end
  
end