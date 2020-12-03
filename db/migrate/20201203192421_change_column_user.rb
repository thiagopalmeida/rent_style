class ChangeColumnUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :birth_date, :date
  end
end
