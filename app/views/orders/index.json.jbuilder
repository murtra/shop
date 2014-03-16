json.array!(@orders) do |order|
  json.extract! order, :id, :status, :payment_mode, :address, :city, :name, :last_name
  json.url order_url(order, format: :json)
end
