require 'spec_helper'

describe 'Sidebar' do

  it 'has a list of popular tags'

  context 'As a guest' do

    it 'asks you to sign in'

  end

  context 'As a signed in user' do

    context 'Your Feed' do

      it 'has a link to your feed'
      it 'has a link to your RSS feed'
      it 'has a link to your JSON feed'

    end

    context 'Your Posts' do

      it 'shows your posts'
      it 'does not show posts by others'
      it 'shows public posts'
      it 'shows private posts'
      it 'shows your posts in order updated'

    end

    context 'Starred Posts' do

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

