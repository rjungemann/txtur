class TagsController < ApplicationController

  def show
    @tag_name = params[:id]

    raise 'Tag name must be provided' unless @tag_name

    @tag = Tag.for_name(@tag_name).first
  end

end
