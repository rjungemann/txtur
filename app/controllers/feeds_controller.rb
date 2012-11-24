class FeedsController < ApplicationController

  def show
    @facebook_id = params[:id]
    @user_info = @graph.get_object @facebook_id

    @posts = Post.public.for_user_id(@facebook_id).by_created

    respond_to do |format|
      format.html
      format.json { render :json => @posts.to_json, :layout => false }
      format.rss  { render :layout => false }
    end
  end

end

