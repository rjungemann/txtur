class AddStarCountToPosts < ActiveRecord::Migration

  def change
    add_column :posts, :star_count, :integer, :default => 0
  end

end

