class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :quantity
      t.belongs_to :aauction, index: true, foreign_key: true,null:false
      t.belongs_to :seller, index: true,null: false
      t.datetime :aauction_window_starts_at
      t.datetime :aauction_window_ends_at
      t.integer :minimum_bid
      t.string :display_description

      t.timestamps null: false
    end
    add_foreign_key :products,:users, column: :seller_id
  end
end
