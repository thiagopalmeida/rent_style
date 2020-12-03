class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :category
      t.string :subcategory
      t.string :brand
      t.string :size
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
