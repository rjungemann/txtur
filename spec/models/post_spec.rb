# encoding: utf-8

require 'spec_helper'

describe Post do

  describe '.uuid' do

    it 'returns a properly-formatted uuid' do
      regex = /[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/i

      Post.uuid.should match regex
    end

  end

  describe '#contents=' do

    it 'sets Markdown contents' do
      post = Post.new
      post.contents = '*Hello*, world!'

      post.markdown_contents.should == '*Hello*, world!'
    end

    it 'sets HTML contents' do
      post = Post.new
      post.contents = '*Hello*, world!'

      post.html_contents.should == '<p><em>Hello</em>, world!</p>'
    end

  end

  describe '#summary' do

    it 'provides a summary for text less than 150 characters' do
      post = Post.new
      post.contents = '*Hello*, world!'

      post.summary.should == 'Hello, world!'
    end

    it 'provides a summary for text more than 150 characters' do
      post = Post.new
      post.contents = '*Hello*, world! _What_ is going on? Craziness, ' +
        'indeed. So much text, so much text. Blah, blah, blah. Is this ' +
        'enough text, do you think? Most likely not. Best keep typing some ' +
        'more text. You never know if you have enough text. Blah, boring, ' +
        'boring, boring.'


      post.summary.should == 'Hello, world! What is going on? Craziness, ' +
        'indeed. So much text, so much text. Blah, blah, blah. Is this ' +
        'enough text, do you think? Most likely not...'
    end

  end

  describe '#tags=' do

    it 'creates a series of tags' do
      post = Post.create

      post.tags.count.should == 0

      post.tags = 'foo, bar, Bar, bar, baz, ¬_¬'

      post.tags.count.should == 5

      %w[foo bar Bar baz ¬_¬].each do |tag_name|
        post.tags.where(:name => tag_name).should exist
      end

      post.tags = 'yep, nope'

      post.tags.count.should == 2

      %w[yep nope].each do |tag_name|
        post.tags.where(:name => tag_name).should exist
      end
    end

  end

end
