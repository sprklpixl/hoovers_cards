module Spree
  module CheckoutControllerDecorator
    def self.prepended(base)
      base.before_action :add_save_address_checkbox, only: :edit
    end

    def add_save_address_checkbox
      if params[:state] == 'address'
        @order = current_order
        @user_addresses = spree_current_user.addresses if spree_current_user
      end
    end
  end
end

Spree::CheckoutController.prepend Spree::CheckoutControllerDecorator
