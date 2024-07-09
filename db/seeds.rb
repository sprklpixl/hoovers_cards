require 'csv'

# Clear the products and categories tables
Product.delete_all
Category.delete_all

csv_text = File.read(Rails.root.join('lib', 'seeds', 'products-hooverscards.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

categories = {}

csv.each do |row|
  category_name = row['CATEGORIES']

  # Find or create the category
  category = categories[category_name] ||= Category.find_or_create_by(name: category_name)

  unless category.persisted?
    puts "Failed to save category: #{category.errors.full_messages.join(', ')}"
    next
  end

  # Extracting integer part from SKU column
  sku_text = row['SKU']
  sku_integer = sku_text.scan(/\d+/).join.to_i

  # Create a new product
  p = Product.new
  p.product_id = "#{row['PRODUCT ID']}#{sku_integer}" # Concatenating PRODUCT ID and integer part of SKU
  p.title = row['TITLE']
  p.image = row['IMAGE']
  p.category = category
  p.type = row['OPTION1 VALUE']
  p.price = row['PRICE']
  p.sale_price = row['SALE PRICE']
  p.inventory = row['INVENTORY'].to_i # Assuming INVENTORY column contains only integers

  if p.save
    puts "#{p.product_id} saved"
  else
    puts "Failed to save product: #{p.errors.full_messages.join(', ')}"
  end
end

puts "There are now #{Product.count} rows in the products table."
puts "There are now #{Category.count} rows in the categories table."
