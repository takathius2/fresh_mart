class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id, null:false
      t.string :item_name, null: false
      t.string :introduction, null: false
      t.integer :content_volume, null: false
      t.string :unit, null: false
      t.integer :no_tax_item_price, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
