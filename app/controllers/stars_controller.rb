class StarsController < ApplicationController

  def create
    raise 'User is not signed in.' unless @user_id
    raise 'Post ID must be provided.' unless params[:post_id]

    @post = Post.where(:uuid => params[:post_id]).first

    raise 'Post does not exist.' unless @post

    if Star.where(:facebook_id => @user_id).count > 0
      raise 'You already starred this post'
    end

    user_info = @graph.get_object('me')

    @star = Star.new

    @star.facebook_id = @user_id
    @star.full_name   = user_info['name']
    @star.first_name  = user_info['first_name']
    @star.last_name   = user_info['last_name']

    @star.post = @post

    @star.save!

    redirect_to :controller => 'posts', :action => 'show', :id => @post.uuid
  end

  def destroy
    raise 'User is not signed in.' unless @user_id
    raise 'Post ID must be provided.' unless params[:id]

    user_info = @graph.get_object('me')

    @post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless @post

    Star.where(:facebook_id => @user_id).destroy_all

    redirect_to :controller => 'posts', :action => 'show', :id => @post.uuid
  end

end

