class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true
  belongs_to :cart, optional: true
  belongs_to :type

  def unit_price
    product.sale_price || product.price
  end

  def total_price
    unit_price * quantity
  end
end
