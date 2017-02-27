class CreateProductsAndFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features_products, :id => false do |t|
      t.belongs_to :product, :index => true, :foreign_key => true
      t.belongs_to :feature, :index => true, :foreign_key => true
    end
  end
end
