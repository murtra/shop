class Order < ActiveRecord::Base
  ALLOWED_PAYMENT_MODES = ["cash", "card", "paypal"] #I18n.t('order.allowed_payment_modes')
  ALLOWED_STATUS = ["pending", "send", "received"]

  before_validation :set_status, only: [:create]

  validates :name, :last_name, :address, :city, :payment_mode, :status, presence: true
  validates :payment_mode, inclusion: { in: Order::ALLOWED_PAYMENT_MODES, message: I18n.t('errors.messages.inclusion') }
  #validates :status, inclusion: { in: Order::ALLOWED_STATUS, message: I18n.t('generic.invalid') }

  has_many :line_items
  has_many :products, through: :line_items

  accepts_nested_attributes_for :line_items, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:product_id].blank? || attributes[:quantity].blank? }

  def total_price
    line_items.to_a.sum {|l| l.price * l.quantity}
  end

  private

    # Set status to "pending" on create
    def set_status
      self.status = "pending"
    end

    def allowed_payment_modes
      I18n.t('order.allowed_payment_modes')
    end
end
