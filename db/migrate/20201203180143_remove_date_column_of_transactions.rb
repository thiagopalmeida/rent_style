class RemoveDateColumnOfTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :date, :date
  end
end
