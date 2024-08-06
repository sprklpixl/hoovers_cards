class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_product(product, type, quantity = 1)
    current_item = order_items.find_by(product: product, type: type)
    if current_item
      current_item.increment(:quantity, quantity)
    else
      current_item = order_items.build(product: product, type: type, quantity: quantity)
    end
    current_item.save
  end

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end
  
  # def checkout
  #   order = user.orders.create(total_price: total_price, status: 'pending')
  #   cart_items.each do |item|
  #     order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price)
  #   end
  #   cart_items.destroy_all
  #   order
  # end

  # def total_price
  #   cart_items.sum { |item| item.quantity * item.product.price }
  # end
end
