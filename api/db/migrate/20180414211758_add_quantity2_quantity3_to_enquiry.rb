class AddQuantity2Quantity3ToEnquiry < ActiveRecord::Migration[5.1]
  def change
    add_column(:enquiries, :quantity2, :integer, default: 0)
    add_column(:enquiries, :quantity3, :integer, default: 0)
  end
end
