class VideosController < ApplicationController
  
  before_action :set_technique
  respond_to :json, :html
  
  def create
    @video = Video.create :technique_id => params[:technique_id], 
                          :link => params[:link],
                          :user => current_user
    respond_with @technique, @video
  end
  
  def destroy
    @video = @technique.videos.find params[:id]
    @video.destroy
    respond_with @technique, @video
  end
  
  private
  def set_technique
    @technique = Technique.find params[:technique_id]
  end
  
end