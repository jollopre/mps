class CreateFeatureOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_options do |t|
      t.string :name
      t.belongs_to :feature, :foreign_key => true
      t.timestamps
    end
  end
end
