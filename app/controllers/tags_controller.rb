class TagsController < ApplicationController

  def show
    @tag_name = params[:id]
    @tag = Tag.where(:name => @tag_name).first
  end

end
