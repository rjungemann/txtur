class SharesController < ApplicationController

  before_filter :authenticate!

  def create
    raise 'User is not signed in.' unless @user_id
    raise 'Post ID must be provided.' unless params[:id]

    @post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless @post

    unless @post.facebook_id == @user_id
      raise 'You are not the author of this post.'
    end

    message     = params[:message]
    name        = @post.title
    description = @post.html_contents
    link        = url_for \
      :controller => 'posts',
      :action     => 'show',
      :id         => @post.uuid

    @graph.put_wall_post message,
      'name'        => name,
      'description' => description,
      'link'        => link

    render :json => {
      :message     => message,
      :name        => name,
      :description => description,
      :link        => link
    }
  end

end
