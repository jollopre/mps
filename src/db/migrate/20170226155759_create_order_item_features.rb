class CreateOrderItemFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features_order_items do |t|
      t.belongs_to :feature, :foreign_key => true
      t.belongs_to :order_item, :foreign_key => true
      t.string :value, :null => false
      t.timestamps
    end
  end
end
