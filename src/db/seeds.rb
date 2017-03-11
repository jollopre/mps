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
		Feature.create({ name: value[:name], feature_type: value[:feature_type] })
	end
end

def populate_feature_options(feature_name, values)
	feature = Feature.find_by(name: feature_name)
	values.each do |value|
		FeatureOption.create({name: value, feature_id: feature.id })
	end
end

# Adds features for a product
def populate_feature_products(product, feature)

end

populate_products([
	{ name: 'Plastic Carrier Bag'},
	{ name: 'Kraft Paper Carrier Bag'},
	{ name: 'Luxury Paper Carrier Bag'},
	{ name: 'Gift Box'},
	{ name: 'Tissue Paper'},
	{ name: 'Ribbon'},
	{ name: 'Labels'},
	{ name: 'Garment Covers'},
	{ name: 'Jewelery Boxes'},
	{ name: 'Fabric Pouch'}
])

populate_features([
	{ name: 'Bag Style', feature_type: 'options' },
	{ name: 'Handle Style', feature_type: 'options' },
	{ name: 'Handle Colour', feature_type: 'text' },
	{ name: 'Handle Material', feature_type: 'text '},	# Luxury Paper Carrier bag has PP, Cotton and GG options
	{ name: 'Turnover Top', feature_type: 'options' },
	{ name: 'Material', feature_type: 'options' },
	{ name: 'Material', feature_type: 'text '},
	{ name: 'Colour', feature_type: 'text'},
	{ name: 'GSM or Thickness', feature_type: 'number' },
	{ name: 'Micron', feature_type: 'number' },
	{ name: 'Film Colour', feature_type: 'text' },
	{ name: 'Width', feature_type: 'number' },
	{ name: 'Height', feature_type: 'number' },
	{ name: 'Depth', feature_type: 'number' },
	{ name: 'No. Printed Colours (Outside)', feature_type: 'number' },
	{ name: 'No. Printed Colours (Inside)', feature_type: 'number' },	# Only for Luxury Paper Carrier Bag
	{ name: 'No. Printed Sides', feature_type: 'number' },
	{ name: '% Ink Coverage (in)', feature_type: 'number' },
	{ name: '% Ink Coverage (out)', feature_type: 'number' },
	{ name: 'Finish (in)', feature_type: 'options' },
	{ name: 'Finish (out)', feature_type: 'options' },
	{ name: 'Card Base', feature_type: 'options' },
	{ name: 'Handle Tie Style', feature_type: 'options' },
	{ name: 'Textured Embossed Finish', feature_type: 'options' },
	{ name: 'Tissue Paper Packing', feature_type: 'options' },
	{ name: 'Create Fold In Base', feature_type: 'options' },
	{ name: 'Box Style', feature_type: 'options' },
	{ name: 'Thumbcuts', feature_type: 'options' },
	{ name: 'Insert', feature_type: 'text'},
	{ name: 'Foil', feature_type: 'text'},
	{ name: 'Packing (reams)', feature_type: 'number' },
	{ name: 'Print', feature_type: 'options'},
	{ name: 'Register Print', features_type: 'options' }
])

populate_feature_options('Bag Style', ['Bottom Gusset', 'Side Gusset', 'Block Bottom', 'SOS (Self Opening Satchel', 'Unstrung', 'Luxury Art Carrier'])
populate_feature_options('Handle Style', ['Patch', 'Side Gusset', 'Block Bottom', 'Vest', 'Clip Close', 'TOT (Turnover Top)', 'Twisted Paper', 'Rope', 'Sack', 'Ribbon', 'Die Cut', 'Two Piece Box', 'Fold Flat Box'])
populate_feature_options('Turnover Top', ['Yes', 'No'])
populate_feature_options('Material', ['Hdpe', 'Ldpe', 'Tissue Paper', 'Double Faced Polyester Satin', 'Polyester Grossgrain', 'Vinyl', 'Art Paper']) # Material can be options or text (CHECK)
populate_feature_options('Finish (in)', ['Matt', 'Gloss Lamination', 'Gloss Sealer'])
populate_feature_options('Finish (out)', ['Matt', 'Gloss Laquer', 'Gloss Lamination'])
populate_feature_options('Card Base', ['Yes', 'No'])	# Always Yes for Luxury Paper Carrier Bag
populate_feature_options('Handle Tie Style', ['Knotted', 'Glued'])
populate_feature_options('Textured Embossed Finish', ['Yes', 'No'])
populate_feature_options('Tissue Paper Packing', ['Yes', 'No'])
populate_feature_options('Create Fold In Base', ['Yes', 'No'])
populate_feature_options('Box Style', ['Rigid', 'Magnetic Folding', 'Folding Double Walled', 'Tuck in lid', 'Base Carton']) # Is this multi-valued ??
populate_feature_options('Thumbcuts', ['Yes', 'No'])
populate_feature_options('Print', ['Screen', 'Foil', 'Cold Foil', 'Puffy'])
populate_feature_options('Register Print', ['Yes', 'No'])

# TODO populate features_products, feature_options_products JOIN tables

