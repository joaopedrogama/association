class AddIndexToDebtsAmount < ActiveRecord::Migration[6.0]
  def change
    add_index :debts, :amount
  end
end
