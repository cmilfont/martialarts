class MartialartsController < ApplicationController
  
  before_action :set_martialart, :only => [:show, :edit, :update, :destroy]
 
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :authorize_user!, :only => [:new, :edit, :create, :update, :destroy]

  respond_to :json, :html

  def index
    @martialarts = Martialart.all.order(:name)
    respond_with @martialarts
  end

  def show
    respond_with @martialart
  end

  def new
    @martialart = Martialart.new
  end

  def edit
  end

  def create
    @martialart = Martialart.create martialart_params
    respond_with @martialart
  end

  def update
    @martialart.update martialart_params
    respond_with @martialart
  end

  def destroy
    @martialart.destroy
    respond_with @martialart
  end

  private
    def set_martialart
      @martialart = Martialart.find(params[:id])
    end

    def martialart_params
      params.require(:martialart).permit(:name, :description)
    end
end
