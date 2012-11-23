class ImportsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    raise 'User is not signed in.' unless @user_id

    user_info = @graph.get_object 'me'

    file = params[:post].delete :markdown_file

    raise 'File must be provided.' unless file

    @post = Post.new params[:post]

    @post.uuid        = Post.uuid
    @post.contents    = file.tempfile.read
    @post.facebook_id = @user_id
    @post.full_name   = user_info['name']
    @post.first_name  = user_info['first_name']
    @post.last_name   = user_info['last_name']

    @post.save!

    flash[:notice] = 'Post was successfully imported.'

    redirect_to :controller => 'posts', :action => 'show', :id => @post.uuid
  end

end

