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

def populate_features(product_name,values)
	product = Product.find_by(name: product_name)
	values.each do |value|
		Feature.create({ name: value[:name], feature_type: value[:feature_type], product_id: product.id })
	end
end

def populate_feature_options(product_name, feature_name, values)
	feature = Feature.find_by(name: feature_name, product_id: Product.find_by(name: product_name).id)
	values.each do |value|
		FeatureOption.create({name: value, feature: feature })
	end
end

populate_products([
	{ name: 'Plastic Carrier Bag'},
	{ name: 'Kraft Paper Carrier Bag'},
	{ name: 'Luxury Paper Carrier Bag'},
	{ name: 'Rigid Gift Box'},
	{ name: 'Folding Gift Box'},
	{ name: 'Tissue Paper'},
	{ name: 'Ribbon'},
	{ name: 'Labels'},
	{ name: 'Garment Covers'},
	{ name: 'Jewelery Boxes'},
	{ name: 'Fabric Pouch'}
])

populate_features('Plastic Carrier Bag',[
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

populate_features('Kraft Paper Carrier Bag',[
	{ name: 'Bag Style', feature_type: 'options' },
	{ name: 'Handle Style', feature_type: 'options' },
	{ name: 'Handle Colour', feature_type: 'text' },
	{ name: 'Handle Material', feature_type: 'text '},
	{ name: 'Turnover Top', feature_type: 'options' },
	{ name: 'Material', feature_type: 'options' },
	{ name: 'GSM', feature_type: 'number' },
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

populate_feature_options('Plastic Carrier Bag','Bag Style', ['Bottom Gusset', 'Side Gusset', 'Block Bottom'])
populate_feature_options('Plastic Carrier Bag','Handle Style', ['Patch', 'Side Gusset', 'Block Bottom', 'Vest', 'Clip Close', 'TOT (Turnover Top)'])
populate_feature_options('Plastic Carrier Bag','Turnover Top', ['Yes', 'No'])
populate_feature_options('Plastic Carrier Bag','Material', ['Hdpe', 'Ldpe'])
populate_feature_options('Plastic Carrier Bag','Finish', ['Matt', 'Gloss Laquer'])
populate_feature_options('Plastic Carrier Bag','Card Base', ['Yes', 'No'])

populate_feature_options('Kraft Paper Carrier Bag','Bag Style', ['SOS (Self Opening Satchel', 'Unstrung'])
populate_feature_options('Kraft Paper Carrier Bag','Handle Style', ['Twisted Paper', 'Rope', 'Sack'])
populate_feature_options('Kraft Paper Carrier Bag','Turnover Top', ['Yes', 'No'])
populate_feature_options('Kraft Paper Carrier Bag','Material', ['Hdpe', 'Ldpe'])
populate_feature_options('Kraft Paper Carrier Bag','Finish', ['Matt', 'Gloss Laquer'])
populate_feature_options('Kraft Paper Carrier Bag','Card Base', ['Yes', 'No'])

