require 'spec_helper'

describe 'Welcome', :js => true do

  it 'shows a welcome page' do
    visit root_path

    page.should have_content('Share snippets with Txtur')
  end

  it 'allows user to sign in' do
    visit root_path

    page.should have_content('Sign into Facebook')

    signin!

    visit root_path

    page.should have_content('Sign out')

    signout!

    visit root_path

    page.should have_content('Sign into Facebook')
  end

  context 'Starred Posts' do

    it 'only shows section if posts are present' do
      visit root_path

      page.should have_no_content('Most Starred Posts')

      post = Post.new

      post.title    = 'Starred Post'
      post.contents = 'Should be shown'

      post.save!

      star = Star.create

      post.stars << star

      post.update_star_count!

      visit root_path

      page.should have_content('Most Starred Posts')
    end

    it 'shows starred posts' do
      post = Post.new

      post.title    = 'Starred Post'
      post.contents = 'Should be shown'

      post.save!

      star = Star.create

      post.stars << star

      post.update_star_count!

      post2 = Post.new

      post2.title    = 'Unstarred Post'
      post2.contents = 'Should be hidden'

      post2.save!

      visit root_path

      page.text.should match(/Most Starred Posts.*Starred Post.*Recently Updated Posts/m)
      page.text.should_not match(/Most Starred Posts.*Unstarred Post.*Recently Updated Posts/m)
    end

    it 'shows public posts' do
      # Create a public post

      post = Post.new

      post.title    = 'Public Post'
      post.contents = 'Should be public'
      post.public   = true

      post.save!

      star = Star.create

      post.stars << star

      post.update_star_count!

      # Create a private post

      post2 = Post.new

      post2.title    = 'Private Post'
      post2.contents = 'Should be private'
      post2.public   = false

      post2.save!

      star2 = Star.create

      post2.stars << star

      post2.update_star_count!

      visit root_path

      page.text.should match(/Most Starred Posts.*Public Post.*Recently Updated Posts/m)
      page.should have_no_content('Private Post')
    end

    it 'shows 5 most recent posts' do
      6.times do |i|
        post = Post.new

        post.title    = "Foo #{i + 1}"
        post.public   = true
        post.contents = 'Hello!'

        post.save!

        star = Star.create

        post.stars << star

        post.update_star_count!
      end

      visit root_path

      page.text.should match(/Most Starred Posts.*Foo 6.*Foo 5.*Foo 4.*Foo 3.*Foo 2.*Recently Updated Posts/m)
      page.should have_no_content('Foo 1')
    end

  end

  context 'Recent Posts' do

    it 'only shows section if posts are present' do
      visit root_path

      page.should have_no_content('Recently Updated Posts')

      post = Post.new

      post.title    = 'Starred Post'
      post.contents = 'Should be shown'

      post.save!

      visit root_path

      page.should have_content('Recently Updated Posts')
    end

    it 'shows public posts' do
      # Create a public post

      post = Post.new

      post.title    = 'Public Post'
      post.contents = 'Should be public'
      post.public   = true

      post.save!

      # Create a private post

      post2 = Post.new

      post2.title    = 'Private Post'
      post2.contents = 'Should be private'
      post2.public   = false

      post2.save!

      visit root_path

      page.text.should match(/Recently Updated Posts.*Public Post/m)
      page.should have_no_content('Private Post')
    end

    it 'shows 5 most recent posts' do

      6.times do |i|
        post = Post.new

        post.title    = "Foo #{i + 1}"
        post.public   = true
        post.contents = 'Hello!'

        post.save!
      end

      visit root_path

      page.text.should match(/Recently Updated Posts.*Foo 6.*Foo 5.*Foo 4.*Foo 3.*Foo 2/m)
      page.should have_no_content('Foo 1')

    end

  end

end

