class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_item, :remove_item, :update_item]

  def show
  end

  def add_item
    @product = Product.find(params[:product_id])
    @type = Type.find(params[:type_id])
    @cart.add_product(@product, @type, params[:quantity].to_i)
    redirect_to cart_path
  end

  def remove_item
    order_item = @cart.order_items.find(params[:order_item_id])
    order_item.destroy
    redirect_to cart_path
  end

  def update_item
    order_item = @cart.order_items.find(params[:order_item_id])
    order_item.update(quantity: params[:quantity])
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end


#   def show
#     @cart = current_user.cart
#   end

#   def add_item
#     @cart = current_user.cart
#     product = Product.find(params[:product_id])
#     type = Type.find(params[:type_id])
#     quantity = params[:quantity].to_i

#     cart_item = @cart.cart_items.find_or_initialize_by(product: product)
#     cart_item.quantity = quantity
#     cart_item.save

#     redirect_to cart_path, notice: 'Item added to cart.'
#   end

#   def remove_item
#     @cart = current_user.cart
#     cart_item = @cart.cart_items.find(params[:id])
#     cart_item.destroy

#     redirect_to cart_path, notice: 'Item removed from cart.'
#   end
# end
