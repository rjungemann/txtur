class AddNamesToPosts < ActiveRecord::Migration

  def change
    add_column :posts, :first_name, :string
    add_column :posts, :last_name, :string
    add_column :posts, :full_name, :string
  end

end

