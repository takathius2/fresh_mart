class CreateOrderDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :order_destinations do |t|
      t.string "address"
      t.string "postal_code"
      t.string "name"
      t.string "name_kana"
      t.string "telephone_number"
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
