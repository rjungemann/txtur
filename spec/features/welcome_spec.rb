require 'spec_helper'

describe 'Welcome', :js => true do

  it 'shows a welcome page' do
    visit root_path

    page.should have_content('Share snippets with Txtur')

    pending
  end

  it 'shows a list of recent posts' do
    # Create some public posts

    %w[Foo Foo\ 2 Foo\ 3].each do |title|
      post = Post.new

      post.title    = title
      post.public   = true
      post.contents = 'Hello!'

      post.save!
    end

    # Create a private post

    post = Post.new

    post.title    = 'Private Post'
    post.contents = 'Should be private'
    post.public   = false

    post.save!

    visit root_path

    page.text.should match(/Recently Updated Posts.*Foo 3.*Foo 2.*Foo/m)
    page.should have_no_content('Private Post')
  end

end

