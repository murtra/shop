require 'spec_helper'

describe Order do
  it 'calculates total price' do
    carrot = create_product
    potato = create_product(name: "potato", price: 22)

    order =  Order.create!(name: "Almudena", last_name: "Garcia", address: "Av. Lluis Pericot, 47", city: "Girona", payment_mode: "paypal")

    line_item_1 =  order.line_items.create!(quantity: 2, product: carrot)
    line_item_2 =  order.line_items.create!(quantity: 1, product: potato)

    expect(order.total_price).to eq(102)
  end
end
