class AddOrganizationToAauctions < ActiveRecord::Migration
  def change
    add_reference :aauctions, :organization, index: true, foreign_key: true,null: false
  end
end
