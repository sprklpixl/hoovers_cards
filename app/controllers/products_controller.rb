class ProductsController < ApplicationController
  def index
    # @products = Product.all
    @products = Product.page(params[:page]).per(10)
    @categories = Category.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Product not found."
    redirect_to products_path
  end

  def search
    @categories = Category.all
    @products = Product.all

    if params[:search].present?
      @products = @products.where('title LIKE ?', "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).per(10)

    render :index
  end
end
