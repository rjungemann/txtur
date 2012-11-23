require 'spec_helper'

describe Tag do

  describe '.reap_orphaned!' do

    it 'destroys all unassociated tags' do
      post = Post.create :title => 'First Post!', :contents => 'Hello!'
      post.post_tags = 'foo, bar, baz'

      post.destroy

      Tag.count.should == 3

      post2 = Post.create :title => 'Second Post!', :contents => 'What!?'
      post2.post_tags = 'foo'

      Tag.count.should == 3

      Tag.reap_orphaned!

      Tag.count.should == 1
      Tag.first.name.should == 'foo'
    end

  end

end

