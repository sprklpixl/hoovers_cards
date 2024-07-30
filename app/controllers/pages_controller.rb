class PagesController < ApplicationController
  def home
    @products = Product.all
  end
  def about
    @about = About.find_by(id: 1)
  end
  def contact
    @contact = Contact.find_by(id: 1)
  end
end
