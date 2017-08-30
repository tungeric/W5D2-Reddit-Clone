class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false
      t.integer :post_id, null: false
      t.integer :parent_comment_id
      t.text :content, null: false
      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, :post_id
    add_index :comments, :parent_comment_id
  end
end
