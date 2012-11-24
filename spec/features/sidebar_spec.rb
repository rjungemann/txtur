require 'spec_helper'

describe 'Sidebar' do

  it 'has a list of popular tags' do
    visit root_path

    within '.sidebar-nav' do
      page.should have_no_content('Popular Tags')
    end

    Tag.create :name => 'foo'
    Tag.create :name => 'bar'
    Tag.create :name => 'baz'

    visit root_path

    within '.sidebar-nav' do
      page.should have_content('Popular Tags')
      page.should have_content('foo, bar, baz')

      find('a', :text => 'foo')[:href].should == '/tags/foo'
      find('a', :text => 'bar')[:href].should == '/tags/bar'
      find('a', :text => 'baz')[:href].should == '/tags/baz'
    end
  end

  context 'As a guest' do

    it 'asks you to sign in' do
      visit root_path

      within '.sidebar-nav' do
        page.should have_content('Please sign in to post.')
      end
    end

  end

  context 'As a signed in user' do

    describe 'Your Feed' do

      before :each do
        signin!
      end

      after :each do
        signout!
      end

      it 'has a link to your feed' do
        visit root_path

        within '.sidebar-nav' do
          find('a', :text => 'HTML')[:href].should == '/feeds/1234'
        end
      end

      it 'has a link to your RSS feed' do
        visit root_path

        within '.sidebar-nav' do
          find('a', :text => 'RSS')[:href].should == '/feeds/1234.rss'
        end
      end

      it 'has a link to your JSON feed' do
        visit root_path

        within '.sidebar-nav' do
          find('a', :text => 'JSONP')[:href].should  == '/feeds/1234.json'
          find('a', :text => 'JSONP')[:title].should == 'You can provide an optional "callback" parameter.'
        end
      end

    end

    describe 'Your Posts' do

      it 'shows your posts'
      it 'does not show posts by others'
      it 'shows public posts'
      it 'shows private posts'
      it 'shows your posts in order updated'

    end

    describe 'Starred Posts' do

      it 'shows starred posts'
      it 'does not show unstarred posts'
      it 'shows posts in order starred'
      it 'shows public posts'
      it 'shows private posts'
      it 'shows your posts'
      it 'shows posts created by others'

    end

  end

end

