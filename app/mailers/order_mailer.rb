class OrderMailer < ActionMailer::Base
  default from: "murtra@murtra.net" 
  
  def order_created(order, user)
    @order = order
    mail subject: "New order", to: user.email
  end 
end
