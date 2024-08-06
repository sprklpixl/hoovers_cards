class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def checkout
    order = user.orders.create(total_price: total_price, status: 'pending')
    cart_items.each do |item|
      order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price)
    end
    cart_items.destroy_all
    order
  end

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end
end
