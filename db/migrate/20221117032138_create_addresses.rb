class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :postal_code
    	t.string :postal_address
    	t.string :postal_name
    	t.string :postal_name_kana
    	t.string :postal_telephone_number

      t.timestamps
    end
  end
end
