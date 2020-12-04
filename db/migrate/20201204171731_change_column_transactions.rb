class ChangeColumnTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :price, :decimal
  end
end
