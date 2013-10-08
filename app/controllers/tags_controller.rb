class TagsController < ApplicationController

  respond_to :json

  def index
    @tags = Tag.simple_search params
    respond_with @tags
  end

end
