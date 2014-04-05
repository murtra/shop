class Order < ActiveRecord::Base   
  ALLOWED_PAYMENT_MODES = ["cash", "card", "paypal"]
  ALLOWED_STATUS = ["pending", "send", "received"]    
  
  before_validation :set_status, only: [:create]   
  
  validates :name, :last_name, :address, :city, :payment_mode, :status, presence: true
  validates :payment_mode, inclusion: { in: Order::ALLOWED_PAYMENT_MODES,
      message: "is not valid" }
  validates :status, inclusion: { in: Order::ALLOWED_STATUS,
    message: "is not valid" } 
    
  #validates_associated :line_items
  
  has_many :line_items
  has_many :products, through: :line_items 
  
  accepts_nested_attributes_for :line_items, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:product_id].blank? || attributes[:quantity].blank? }  
    
  private 
  
    # Set status to "pending" on create
    def set_status   
      self.status = "pending"
    end  
end
