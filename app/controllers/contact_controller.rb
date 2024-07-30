class ContactController < ApplicationController
  def show
    @contact = Contact.find_by(id: 1)
  end
end
