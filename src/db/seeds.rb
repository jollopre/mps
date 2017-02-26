# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def populate_products(values)
	values.each do |value|
		Product.create(value)
	end
end

def populate_features(values)
	values.each do |value| 
		Feature.create(value)
	end
end

def populate_feature_options(feature_name, values)
	feature = Feature.find_by(name: feature_name)
	values.each do |value|
		FeatureOption.create({name: value, feature: feature })
	end
end

populate_products([
	{ name: 'Plastic Carrier Bag'},
	{ name: 'Kraft Paper Carrier Bag'},
	{ name: 'Luxury Paper Carrier Bag'}
])

populate_features([
	{ name: 'Bag Style', feature_type: 'options' },
	{ name: 'Handle Style', feature_type: 'options' },
	{ name: 'Handle Colour', feature_type: 'text' },
	{ name: 'Turnover Top', feature_type: 'options' },
	{ name: 'Material', feature_type: 'options' },
	{ name: 'Micron', feature_type: 'number' },
	{ name: 'Film Colour', feature_type: 'text' },
	{ name: 'Width', feature_type: 'number' },
	{ name: 'Height', feature_type: 'number' },
	{ name: 'Depth', feature_type: 'number' },
	{ name: 'No. Printed Colours', feature_type: 'number' },
	{ name: 'No. Printed Sides', feature_type: 'number' },
	{ name: '% Ink Coverage', feature_type: 'number' },
	{ name: 'Finish', feature_type: 'options' },
	{ name: 'Card Base', feature_type: 'options' }
])

populate_feature_options('Bag Style', ["Bottom Gusset", "Side Gusset", "Block Bottom"])
populate_feature_options('Handle Style', ["Patch", "Side Gusset", "Block Bottom", "Vest", "Clip Close", "TOT (Turnover Top)"])
populate_feature_options('Turnover Top', ["Yes", "No"])
populate_feature_options('Material', ["Hdpe", "Ldpe"])
populate_feature_options('Finish', ["Matt", "Gloss Laquer"])
populate_feature_options('Card Base', ["Yes", "No"])
