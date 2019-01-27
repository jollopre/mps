class RenameOrdersToQuotations < ActiveRecord::Migration[5.1]
  def change
  	rename_table(:orders, :quotations)
  	rename_column(:order_items, :order_id, :quotation_id)
  end
end
