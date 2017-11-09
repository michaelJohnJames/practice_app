class Posts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :post_title
      t.string :post
      t.integer :user_id
    end
  end
end
