class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
    t.integer "item_id"
    t.integer "order_id"
    t.string "amount_billed_or_claimed"
    t.integer "puroduct_status"
    t.integer "amount"

      t.timestamps
    end
  end
end
