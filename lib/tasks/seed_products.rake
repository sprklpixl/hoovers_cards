namespace :csv do
  desc "Seed products from a CSV file"
  task seed_products: :environment do
    require 'csv'

    csv_text = File.read(Rails.root.join('lib', 'seeds', 'products-hooverscards.csv'))
    filepath = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

    CSV.foreach(filepath, headers: true) do |row|
      next if row['TITLE'].blank? || row['CATEGORY'].blank?

      # Find or create category
      category = Spree::Taxon.find_or_create_by!(name: row['CATEGORY'], taxonomy: Spree::Taxonomy.find_or_create_by!(name: 'Categories'))

      puts "Created category: #{category.name}"

      # Skip duplicate products
      next if Spree::Product.exists?(sku: row['PRODUCT ID'])

      # Create product
      product = Spree::Product.create!(
        name: row['TITLE'],
        price: row['PRICE'].to_f,
        available_on: Time.current,
        shipping_category: Spree::ShippingCategory.find_or_create_by!(name: 'Default')
      )

      # Associate product with category
      product.taxons << category

      # Extracting integer part from SKU column
      # sku_text = row['SKU']
      # sku_integer = sku_text.scan(/\d+/).join.to_i

      # Create options if present
      # unless sku_integer.blank? || row['OPTION1 VALUE'].blank?
      #   option_type = Spree::OptionType.find_or_create_by!(name: row['OPTION1 VALUE'])
      #   option_value = Spree::OptionValue.find_or_create_by!(name: sku_integer, option_type: option_type)
      #   product.option_types << option_type
      #   Spree::Variant.where(product: product).each do |variant|
      #     variant.option_values << option_value
      #   end
      # end

      puts "Created product: #{product.name}"
    end
  end
end
