class CreateFeatureOptionsAndProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_options_products do |t|
    	t.belongs_to :feature_option, :foreign_key => true
    	t.belongs_to :product, :foreign_key => true
    end
  end
end
