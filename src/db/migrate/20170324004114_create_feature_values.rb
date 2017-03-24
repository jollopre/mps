class CreateFeatureValues < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_values do |t|
      t.string :value, :null => false
      t.belongs_to :feature, :foreign_key => true
      t.belongs_to :order_item, :foreign_key => true
      t.timestamps
    end
  end
end
      