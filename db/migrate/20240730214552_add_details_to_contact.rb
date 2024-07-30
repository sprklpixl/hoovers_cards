class AddDetailsToContact < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :address, :string
    add_column :contacts, :phone, :string
    add_column :contacts, :email, :string
    add_column :contacts, :facebook, :string
    add_column :contacts, :twitter, :string
    add_column :contacts, :instagram, :string
    add_column :contacts, :tiktok, :string
    add_column :contacts, :snapchat, :string
  end
end
