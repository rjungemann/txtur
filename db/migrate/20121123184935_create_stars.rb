class CreateStars < ActiveRecord::Migration

  def change
    create_table :stars do |t|
      t.integer :post_id
      t.string :facebook_id
      t.string :first_name
      t.string :last_name
      t.string :full_name

      t.timestamps
    end
  end

end

