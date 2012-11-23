class ChangePrivateToPublicForPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :private
    add_column :posts, :public, :boolean
  end
end
