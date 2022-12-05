class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :customer_id
      t.string :postal_code
    	t.string :destination
    	t.string :name

      t.timestamps
    end
  end
end
