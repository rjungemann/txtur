class DownloadsController < ApplicationController

  def show
    raise 'Post ID must be provided.' unless params[:id]

    post = Post.where(:uuid => params[:id]).first

    raise 'Post does not exist.' unless post

    format = params[:format]

    raise 'Format must be provided.' unless format

    if format == 'json'
      Tempfile.open('post', Rails.root.join('tmp/downloads') ) do |f|
        f.print post.to_json

        f.flush

        send_file f.path, :filename => "#{post.uuid}.json", :type => 'application/json'
      end
    elsif format == 'markdown'
      Tempfile.open('post', Rails.root.join('tmp/downloads') ) do |f|
        f.print post.markdown_contents

        f.flush

        send_file f.path, :filename => "#{post.title}.markdown", :type => 'text/x-web-markdown'
      end
    elsif format == 'html'
      Tempfile.open('post', Rails.root.join('tmp/downloads') ) do |f|
        f.print post.html_contents

        f.flush

        send_file f.path, :filename => "#{post.title}.html", :type => 'text/html'
      end
    end
  end

end

