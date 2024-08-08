ActiveAdmin.register Spree::Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description, :price, :available_on, :sku, :shipping_category_id, variants_attributes: [:id, :sku, :price, :_destroy]


  form do |f|
    f.inputs 'Details' do
      f.input :product_id
      f.input :title
      # f.input :content
      f.input :price
      f.input :sale_price
      f.input :inventory
      f.input :category
      f.input :image, as: :file
    end

    f.inputs 'Types' do
      f.has_many :types, allow_destroy: true, new_record: true do |t|
        t.input :name
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :product_id
    column :title
    column :price
    column :sale_price
    column :inventory
    column :category
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :product_id
      row :title
      # row :content
      row :price
      row :sale_price
      row :inventory
      row :category
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "300x425"
        end
      end
      row :created_at
      row :updated_at
    end

    panel 'Types' do
      table_for product.types do
        column :name
      end
    end
  end

  filter :image_attachment_id
end
