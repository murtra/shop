class LineItem < ActiveRecord::Base 
  before_validation :set_price   
   
  validates :quantity, :price, presence: true
  validates :price, numericality: true
  validates :quantity, numericality: { only_integer: true }
  
  belongs_to :order
  belongs_to :product  
  
  private
  
    def set_price
      self.price = product.price
    end     
    
end
