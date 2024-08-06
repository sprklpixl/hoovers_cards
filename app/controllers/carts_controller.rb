class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
  end

  def add_item
    @cart = current_user.cart
    product = Product.find(params[:product_id])
    type = Type.find(params[:type_id])
    quantity = params[:quantity].to_i

    cart_item = @cart.cart_items.find_or_initialize_by(product: product, type: type)
    cart_item.quantity += quantity
    cart_item.save

    redirect_to cart_path, notice: 'Item added to cart.'
  end

  def remove_item
    @cart = current_user.cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy

    redirect_to cart_path, notice: 'Item removed from cart.'
  end
end
