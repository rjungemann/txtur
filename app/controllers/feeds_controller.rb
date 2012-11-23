class FeedsController < ApplicationController

  def show
    @facebook_id = params[:id]
    @user_info = @graph.get_object @facebook_id

    @posts = Post.where(:public => true).
      where(:facebook_id => @facebook_id).
      order('created_at DESC')

    respond_to do |format|
      format.html
      format.json { render :json => @posts.to_json, :layout => false }
      format.rss  { render :layout => false }
    end
  end

end

