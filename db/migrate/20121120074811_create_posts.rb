class CreatePosts < ActiveRecord::Migration

  def change
    create_table :posts do |t|
      t.string :facebook_id
      t.string :uuid
      t.string :title
      t.text :markdown_contents
      t.text :html_contents

      t.timestamps
    end
  end

end

