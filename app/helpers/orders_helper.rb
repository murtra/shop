module OrdersHelper
  def allowed_payment_modes_with_translations
    Hash[I18n.t('order.allowed_payment_modes').zip(Order::ALLOWED_PAYMENT_MODES)]
  end
end
