class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.string :payment_mode
      t.string :address
      t.string :city
      t.string :name
      t.string :last_name

      t.timestamps
    end
  end
end
