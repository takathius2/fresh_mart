class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :item_name
      t.string :introduction
      t.string :content_volume
      t.string :unit
      t.integer :no_tax_item_price
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
