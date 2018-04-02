class RenameOrderItemsToEnquiries < ActiveRecord::Migration[5.1]
  def change
  	rename_table(:order_items, :enquiries)
  	rename_column(:feature_values, :order_item_id, :enquiry_id)
  end
end
