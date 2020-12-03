class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :birth_date, :datetime
    add_column :users, :telephone, :string
  end
end
