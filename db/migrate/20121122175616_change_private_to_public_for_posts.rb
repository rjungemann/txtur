class ChangePrivateToPublicForPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :private, :boolean
    add_column :posts, :public, :boolean, :default => 1
  end
end
