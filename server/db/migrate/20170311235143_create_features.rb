class CreateFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features do |t|
      t.integer :feature_type, :index => true
      t.belongs_to :product, :foreign_key => true
      t.belongs_to :feature_label, :foreign_key => true
      t.timestamps
    end
  end
end