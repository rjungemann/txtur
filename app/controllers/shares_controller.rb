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

    message     = params[:message] ||
      'I just created a short snippet of text with Txtur that I want to share with you!'
    name        = @post.title
    description = @post.summary
    link        = url_for \
      :controller => 'posts',
      :action     => 'show',
      :id         => @post.uuid

    link = 'http://slashdot.org' # for testing

    @graph.put_wall_post message,
      {
        'name'        => name,
        'link'        => link,
        'description' => description
      },
      'me'

    render :json => {
      :message     => message,
      :name        => name,
      :link        => link,
      :description => description
    }
  end

end
