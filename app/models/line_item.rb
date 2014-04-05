class LineItem < ActiveRecord::Base
  before_validation :set_price
  after_create :decrement_stock

  validates :quantity, :price, presence: true
  validates :price, numericality: true
  validates :quantity, numericality: { only_integer: true }

  belongs_to :order
  belongs_to :product

  private

    def set_price
      self.price = product.price
    end

    def decrement_stock
      product.decrement_stock(quantity)
    end
end
