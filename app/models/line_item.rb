class LineItem < ActiveRecord::Base  
  validates :quantity, :price, :product_id, presence: true
  validates :price, numericality: true
  validates :quantity, numericality: { only_integer: true }
  
  belongs_to :order
  belongs_to :product
end
