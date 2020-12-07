class ChangeColumnContentToReviews < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :content, :text
  end
end
