class ChangePriceTypeOnLineItems < ActiveRecord::Migration
  def up 
    change_column :line_items, :price, :decimal, :precision => 8, :scale => 2  
  end

  def down
    change_column :line_items, :price, :integer
  end
end
