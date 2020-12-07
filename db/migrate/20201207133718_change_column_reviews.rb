class ChangeColumnReviews < ActiveRecord::Migration[6.0]
  def change
    rename_column :reviews, :products_id, :product_id
  end
end
