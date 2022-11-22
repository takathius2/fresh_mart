class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :customer_id
      t.string :postal_code, null: false
    	t.string :destination, null: false
    	t.string :name, null: false

      t.timestamps
    end
  end
end
