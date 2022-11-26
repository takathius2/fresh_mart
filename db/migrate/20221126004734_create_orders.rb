class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
    t.integer "customer_id"
    t.integer "payment_method"
    t.integer "delivery_method"
    t.string "delivery_name"
    t.string "delivery_code"
    t.string "delivery_address"
    t.string "cost_price"
    t.string "amount_billed_or_claimed"
    t.integer "order_status"

      t.timestamps
    end
  end
end
