class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :order, index: true
      t.references :product, index: true
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
