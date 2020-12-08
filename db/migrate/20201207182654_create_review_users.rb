class CreateReviewUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :review_users do |t|
      t.string :content
      t.integer :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
