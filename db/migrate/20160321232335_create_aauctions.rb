class CreateAauctions < ActiveRecord::Migration
  def change
    create_table :aauctions do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :name
      t.string :physical_address
      t.datetime :product_window_ends_at
      t.string :time_zone_id

      t.timestamps null: false
    end
  end
end
