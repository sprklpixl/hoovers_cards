class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :title
      t.string :image
      t.string :category
      t.string :type
      t.decimal :price
      t.decimal :sale_price
      t.integer :inventory

      t.timestamps
    end
  end
end
