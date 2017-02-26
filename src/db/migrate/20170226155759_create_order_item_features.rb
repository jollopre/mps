class CreateOrderItemFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :order_item_features do |t|
      t.belongs_to :order_item, :index => true, :foreign_key => true
      t.belongs_to :feature, :index => true, :foreign_key => true
      t.string :value, :default => ''
      t.timestamps
    end
  end
end
