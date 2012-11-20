class PostsController < ApplicationController

  before_filter :authenticate!

  def index
    redirect_to :action => :new
  end

end

