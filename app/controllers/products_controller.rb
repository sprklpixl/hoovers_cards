class ProductsController < ApplicationController
  def index
    # @products = Product.all
    @products = Product.page(params[:page]).per(10)
    @categories = Category.all
    @types = Type.all

    if params[:filter] == 'on_sale'
      @products = @products.on_sale
    elsif params[:filter] == 'recently_updated'
      @products = @products.recently_updated.where.not(id: Product.recently_added.select(:id))
    elsif params[:filter] == 'recently_added'
      @products = @products.recently_added
    end
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
    @types = Type.all

    if params[:search].present?
      @products = @products.where('title LIKE ?', "%#{params[:search]}%")
    end

    if params[:type_id].present?
      @products = @products.where(type_id: params[:type_id])
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).per(10)

    render :index
  end
  
  def by_category
    @category = Category.find(params[:category_id])
    @products = @category.products.page(params[:page]).per(10)
  end
end
