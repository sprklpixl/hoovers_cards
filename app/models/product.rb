class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :types, dependent: :destroy
  accepts_nested_attributes_for :types, allow_destroy: true

  has_one_attached :image

  # Validations
  validates :product_id, presence: true
  validates :title, presence: true
  # validates :price, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category", "category_id", "created_at", "id", "id_value", "image", "inventory", "price", "product_id", "sale_price", "title", "updated_at"]
  end

  scope :on_sale, -> { where.not(sale_price: nil) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago) }
  scope :recently_added, -> { where('created_at >= ?', 3.days.ago) }
end
