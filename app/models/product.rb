class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :type, optional: true

  # Validations
  validates :product_id, presence: true
  validates :title, presence: true
  # validates :price, numericality: { greater_than_or_equal_to: 0 }
end
