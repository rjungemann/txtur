class AddPrivateFieldToPosts < ActiveRecord::Migration

  def change
    add_column :posts, :private, :boolean, :default => 0
  end

end

