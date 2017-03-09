class CreateFeaturesAndProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :features_products, id: false do |t|
    	t.belongs_to :feature, :foreign_key => true
    	t.belongs_to :product, :foreign_key => true
    end
  end
end
