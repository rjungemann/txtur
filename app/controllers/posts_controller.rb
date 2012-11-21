require 'uuidtools'

class PostsController < ApplicationController

  before_filter :authenticate!

  def index
    @post = Post.new

    render 'new'
  end

  def create
    raise 'User is not signed in.' unless @user_id

    @post = Post.new params[:post]

    @post.facebook_id = @user_id
    @post.uuid        = Post.uuid

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

end

