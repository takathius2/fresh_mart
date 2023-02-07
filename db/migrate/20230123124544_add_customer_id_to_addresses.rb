class AddCustomerIdToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :customer, foreign_key: true
    
  end
end
