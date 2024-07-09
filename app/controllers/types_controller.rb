class TypesController < ApplicationController
  def show
    @type = Type.find(params[:id])
    @products = @type.products
  end
end
