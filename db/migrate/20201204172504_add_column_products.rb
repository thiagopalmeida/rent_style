class AddColumnProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :available, :boolean, default: true
  end
end
