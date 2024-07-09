class CreateTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :types do |t|
      t.string :name

      t.timestamps
    end

    add_reference :products, :type, foreign_key: true
  end
end
