require 'uuidtools'

class PostsController < ApplicationController

  def index
    @post = Post.new

    render 'new'
  end

  def new
    @post = Post.new

    render 'new'
  end

  def create
    raise 'User is not signed in.' unless @user_id

    user_info = @graph.get_object('me')

    @post = Post.new params[:post]

    @post.uuid        = Post.uuid
    @post.facebook_id = @user_id
    @post.full_name   = user_info['name']
    @post.first_name  = user_info['first_name']
    @post.last_name   = user_info['last_name']

    @post.save!

    render 'show'
  end

  def show
    raise 'Post ID must be provided.' unless params[:id]

    @post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless @post
  end

  def edit
    raise 'User is not signed in.' unless @user_id
    raise 'Post ID must be provided.' unless params[:id]

    @post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless @post

    unless @post.facebook_id == @user_id
      raise 'You are not the author of this post.'
    end
  end

  def update
    raise 'User is not signed in.' unless @user_id
    raise 'Post ID must be provided.' unless params[:id]

    @post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless @post

    unless @post.facebook_id == @user_id
      raise 'You are not the author of this post.'
    end

    @post.assign_attributes params[:post]
    @post.save!

    render 'show'
  end

  def destroy
    raise 'User is not signed in.' unless @user_id
    raise 'Post ID must be provided.' unless params[:id]

    @post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless @post

    unless @post.facebook_id == @user_id
      raise 'You are not the author of this post.'
    end

    @post.destroy

    flash[:notice] = 'Post was successfully deleted.'

    redirect_to :controller => 'welcome', :action => 'index'
  end

end

