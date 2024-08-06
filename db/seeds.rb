require 'csv'
require 'open-uri'

# Clear the tables
Product.delete_all
Category.delete_all
#Type.delete_all

csv_text = File.read(Rails.root.join('lib', 'seeds', 'products-hooverscards.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

categories = {}
# types = {}

csv.each do |row|
  category_name = row['CATEGORIES']
  #type_name = row['OPTION1 VALUE']

  # Find or create the category
  category = categories[category_name] ||= Category.find_or_create_by(name: category_name)

  unless category.persisted?
    puts "Failed to save category: #{category.errors.full_messages.join(', ')}"
    next
  end

  # Extracting integer part from SKU column
  #sku_text = row['SKU']
  #sku_integer = sku_text.scan(/\d+/).join.to_i

  # Construct the product_id
  product_id = "#{row['PRODUCT ID']}" #{sku_integer} # Concatenating PRODUCT ID and integer part of SKU

  # Skip if product_id already exists
  if Product.exists?(product_id: product_id)
    # puts "Product with product_id #{product_id} already exists. Skipping..."
    # Find or create the type
    # type = types[:type_id] ||= Type.find_or_create_by(id: :type_id)

    # unless type.persisted?
    #   puts "Failed to save type: #{type.errors.full_messages.join(', ')}"
    # end
    next
  end

  # Create a new product
  p = Product.new
  p.product_id = product_id
  p.title = row['TITLE']
  p.category = category
  # p.type = type
  p.price = row['PRICE']
  p.sale_price = row['SALE PRICE']
  p.inventory = row['INVENTORY'].to_i # Assuming INVENTORY column contains only integers

# Figure out how to add types from csv when seeding to save time and make testing easier


  if p.save
    if row['IMAGE'].present?
      begin
        image_url = row['IMAGE']
        downloaded_image = URI.open(image_url)
        p.image.attach(io: downloaded_image, filename: File.basename(URI.parse(image_url).path))
        puts "#{p.product_id} saved with image"
      rescue => e
        puts "Failed to attach image for #{p.product_id}: #{e.message}"
      end
    else
      puts "#{p.product_id} saved without image"
    end
  else
    puts "Failed to save product: #{p.errors.full_messages.join(', ')}"
  end
end

puts "There are now #{Product.count} rows in the products table."
puts "There are now #{Category.count} rows in the categories table."
#puts "There are now #{Type.count} rows in the types table."
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
