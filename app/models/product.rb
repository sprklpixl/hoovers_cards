class Product < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :type, optional: true

  # Validations
  validates :product_id, presence: true
  validates :title, presence: true
  # validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  scope :on_sale, -> { where.not(sale_price: nil) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago) }
  scope :recently_added, -> { where('created_at >= ?', 3.days.ago) }
end
