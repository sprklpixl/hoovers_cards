# require 'csv'
# require 'open-uri'

# # Clear the tables
# Product.delete_all
# Category.delete_all
# #Type.delete_all

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'products-hooverscards.csv'))
# csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

# categories = {}
# #types = {}

# csv.each do |row|
#   category_name = row['CATEGORIES']
#   #type_name = row['OPTION1 VALUE']

#   # Find or create the category
#   category = categories[category_name] ||= Category.find_or_create_by(name: category_name)

#   unless category.persisted?
#     puts "Failed to save category: #{category.errors.full_messages.join(', ')}"
#     next
#   end

#   # Find or create the type
#   # type = types[type_name] ||= Type.find_or_create_by(name: type_name)

#   # unless type.persisted?
#   #   puts "Failed to save type: #{type.errors.full_messages.join(', ')}"
#   #   next
#   # end

#   # Extracting integer part from SKU column
#   #sku_text = row['SKU']
#   #sku_integer = sku_text.scan(/\d+/).join.to_i

#   # Construct the product_id
#   product_id = "#{row['PRODUCT ID']}" #{sku_integer} # Concatenating PRODUCT ID and integer part of SKU

#   # Skip if product_id already exists
#   if Product.exists?(product_id: product_id)
#     puts "Product with product_id #{product_id} already exists. Skipping..."
#     next
#   end

#   # Create a new product
#   p = Product.new
#   p.product_id = product_id
#   p.title = row['TITLE']
#   p.category = category
#   #p.type = row['OPTION1 VALUE']
#   p.price = row['PRICE']
#   p.sale_price = row['SALE PRICE']
#   p.inventory = row['INVENTORY'].to_i # Assuming INVENTORY column contains only integers

#   if p.save
#     if row['IMAGE'].present?
#       begin
#         image_url = row['IMAGE']
#         downloaded_image = URI.open(image_url)
#         p.image.attach(io: downloaded_image, filename: File.basename(URI.parse(image_url).path))
#         puts "#{p.product_id} saved with image"
#       rescue => e
#         puts "Failed to attach image for #{p.product_id}: #{e.message}"
#       end
#     else
#       puts "#{p.product_id} saved without image"
#     end
#   else
#     puts "Failed to save product: #{p.errors.full_messages.join(', ')}"
#   end
# end

# puts "There are now #{Product.count} rows in the products table."
# puts "There are now #{Category.count} rows in the categories table."
# #puts "There are now #{Type.count} rows in the types table."
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Spree::Core::Engine.load_seed
Spree::Auth::Engine.load_seed

require 'csv'

csv = Rails.root.join('lib', 'seeds', 'products-hooverscards.csv')
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'products-hooverscards.csv'))
# csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

CSV.foreach(csv.to_s, headers: true) do |row|
  next if Spree::Product.exists?(slug: row['PRODUCT ID'])

  # next if row['CATEGORY'].blank?

  # Find or create category
  # category = Spree::Taxon.find_or_create_by!(name: row['CATEGORY'], taxonomy: Spree::Taxonomy.find_or_create_by!(name: 'Categories'))

  # puts "Created category: #{category.name}"

  # Create product
  product = Spree::Product.create!(
    slug: row['PRODUCT ID'],
    name: row['TITLE'],
    price: row['PRICE'].to_f,
    available_on: Time.current,
    shipping_category: Spree::ShippingCategory.find_or_create_by!(name: 'Default')
  )

  # Associate product with category
  # product.taxons << category

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
