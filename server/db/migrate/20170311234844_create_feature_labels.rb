class CreateFeatureLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_labels do |t|
    	t.string :name, :index => true
    	t.timestamps
    end
  end
end
