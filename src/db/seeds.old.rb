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
def populate_feature_products(product_name, feature_names)
	product = Product.find_by(name: product_name)
	feature_names.each do |value|
		product.features << Feature.find_by(name: value)
	end
end

# Add feature_options for a product. This is needed since not all feature options for a feature are
# applicable to each product. values is an array of Hashes [{ feature_name: <String>, option_names: [<String>, ...] }, ...]
def populate_feature_options_products(product_name, values)
	product = Product.find_by(name: product_name)
	values.each do |value|
		feature = Feature.find_by(name: value[:feature_name])
		value[:option_names].each do |option_name|
			feature_option = FeatureOption.find_by(name: option_name, feature_id: feature.id)
			product.feature_options << feature_option
		end
	end
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
	{ name: 'Colour', feature_type: 'text'},
	{ name: 'GSM', feature_type: 'number' },
	{ name: 'Micron', feature_type: 'number' },
	{ name: 'Film Colour', feature_type: 'text' },
	{ name: 'Width', feature_type: 'number' },
	{ name: 'Height', feature_type: 'number' },
	{ name: 'Length', feature_type: 'number' },
	{ name: 'Depth', feature_type: 'number' },
	{ name: 'No. Printed Colours (out)', feature_type: 'number' },
	{ name: 'No. Printed Colours (in)', feature_type: 'number' },
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
	{ name: 'Register Print', features_type: 'options' },
	{ name: 'Foils', feature_type: 'options'}
])

populate_feature_options('Bag Style', ['Bottom Gusset', 'Side Gusset', 'Block Bottom', 'SOS (Self Opening Satchel', 'Unstrung', 'Luxury Art Carrier'])
populate_feature_options('Handle Style', ['Patch', 'Side Gusset', 'Block Bottom', 'Vest', 'Clip Close', 'TOT (Turnover Top)', 'Twisted Paper', 'Rope', 'Sack', 'Ribbon', 'Die Cut', 'Two Piece Box', 'Fold Flat Box'])
populate_feature_options('Turnover Top', ['Yes', 'No'])
populate_feature_options('Material', ['Hdpe', 'Ldpe', 'Tissue Paper', 'Double Faced Polyester Satin', 'Polyester Grossgrain', 'Vinyl', 'Art Paper'])
populate_feature_options('Finish (in)', ['Matt', 'Gloss Lamination', 'Gloss Sealer'])
populate_feature_options('Finish (out)', ['Matt', 'Gloss Laquer', 'Gloss Lamination'])
populate_feature_options('Card Base', ['Yes', 'No'])
populate_feature_options('Handle Tie Style', ['Knotted', 'Glued'])
populate_feature_options('Textured Embossed Finish', ['Yes', 'No'])
populate_feature_options('Tissue Paper Packing', ['Yes', 'No'])
populate_feature_options('Create Fold In Base', ['Yes', 'No'])
populate_feature_options('Box Style', ['Rigid', 'Magnetic Folding', 'Folding Double Walled', 'Tuck in lid', 'Base Carton']) # Is this multi-valued ??
populate_feature_options('Thumbcuts', ['Yes', 'No'])
populate_feature_options('Print', ['Screen', 'Foil', 'Cold Foil', 'Puffy'])
populate_feature_options('Register Print', ['Yes', 'No'])
populate_feature_options('Foils', ['Yes', 'No'])

populate_feature_products('Plastic Carrier Bag', ['Bag Style', 'Handle Style', 'Handle Colour', 'Turnover Top',
	'Material', 'Micron', 'Film Colour', 'Width', 'Height', 'Depth', 'No. Printed Colours (out)',
	'No. Printed Sides', '% Ink Coverage (out)', 'Finish (out)', 'Card Base'])	#Material is options type
populate_feature_products('Kraft Paper Carrier Bag', ['Bag Style', 'Handle Style', 'Handle Colour', 'Handle Material',
	'Turnover Top', 'Material', 'Colour', 'GSM', 'Width', 'Height', 'Depth', 'No. Printed Colours (out)',
	'No. Printed Sides', '% Ink Coverage (out)', 'Finish (out)', 'Card Base']) #Material is text type
populate_feature_products('Luxury Paper Carrier Bag', ['Bag Style', 'Handle Style', 'Handle Colour', 'Handle Material',
	'Handle Tie Style', 'Material', 'Colour', 'GSM', 'Width', 'Height', 'Depth', 'No. Printed Colours (out)',
	'No. Printed Colours (in)', '% Ink Coverage (out)', 'Finish (out)', 'Card Base', 'No. Printed Sides',
	'Textured Embossed Finish', 'Tissue Paper Packing', 'Create Fold In Base']) #Material is text type
populate_feature_products('Gift Box', ['Box Style', 'Handle Style', 'Thumbcuts', 'Material', 'Colour',
	'GSM', 'Width', 'Length', 'Depth', 'No. Printed Colours (out)', 'No. Printed Colours (in)',
	'% Ink Coverage (out)', '% Ink Coverage (in)', 'Finish (out)', 'Finish (in)', 'Insert', 'No. Printed Sides',
	'Textured Embossed Finish', 'Tissue Paper Packing', 'Foil']) #Material is text type
populate_feature_products('Tissue Paper', ['Material', 'Colour', 'GSM', 'No. Printed Colours (out)', 'Register Print',
	'% Ink Coverage (out)', 'Packing (reams)']) #Material is text type
populate_feature_products('Ribbon', ['Material', 'Colour', 'Print', 'No. Printed Colours (out)', 'Register Print',
	'% Ink Coverage (out)', 'Packing (reams)']) #Material is options type
populate_feature_products('Labels', ['Material', 'Colour', 'GSM', 'No. Printed Colours (out)', '% Ink Coverage (out)',
	'Foils', 'Packing (reams)']) #Material is options type

populate_feature_options_products('Plastic Carrier Bag', [
	{ feature_name: 'Bag Style', option_names: ['Bottom Gusset', 'Side Gusset', 'Block Bottom'] },
	{ feature_name: 'Handle Style', option_names: ['Patch', 'Side Gusset', 'Block Bottom', 'Vest', 'Clip Close', 'TOT (Turnover Top)'] },
	{ feature_name: 'Turnover Top', option_names: ['Yes', 'No'] },
	{ feature_name: 'Material', option_names: ['Hdpe', 'Ldpe'] },
	{ feature_name: 'Finish (out)', option_names: ['Matt', 'Gloss Laquer'] },
	{ feature_name: 'Card Base', option_names: ['Yes', 'No'] }
])
populate_feature_options_products('Kraft Paper Carrier Bag', [
	{ feature_name: 'Bag Style', option_names: ['SOS (Self Opening Satchel', 'Unstrung'] },
	{ feature_name: 'Handle Style', option_names: ['Twisted Paper', 'Rope', 'Sack'] },
	{ feature_name: 'Turnover Top', option_names: ['Yes', 'No'] },
	{ feature_name: 'Finish (out)', option_names: ['Matt', 'Gloss Laquer'] },
	{ feature_name: 'Card Base', option_names: ['Yes', 'No'] }
])
populate_feature_options_products('Luxury Paper Carrier Bag', [
	{ feature_name: 'Bag Style', option_names: ['Luxury Art Carrier'] },
	{ feature_name: 'Handle Style', option_names: ['Rope', 'Ribbon', 'Die Cut'] },
	{ feature_name: 'Handle Tie Style', option_names: ['Knotted', 'Glued'] },
	{ feature_name: 'Finish (out)', option_names: ['Matt', 'Gloss Lamination'] },
	{ feature_name: 'Card Base', option_names: ['Yes'] },
	{ feature_name: 'Tissue Paper Packing', option_names: ['Yes', 'No'] },
	{ feature_name: 'Create Fold In Base', option_names: ['Yes', 'No'] }
])
populate_feature_options_products('Gift Box', [
	{ feature_name: 'Box Style', option_names: ['Rigid', 'Magnetic Folding', 'Folding Double Walled', 'Tuck in lid', 'Base Carton'] },
	{ feature_name: 'Handle Style', option_names: ['Two Piece Box', 'Fold Flat Box'] },
	{ feature_name: 'Thumbcuts', option_names: ['Yes', 'No'] },
	{ feature_name: 'Finish (out)', option_names: ['Matt', 'Gloss Lamination'] },
	{ feature_name: 'Finish (in)', option_names: ['Matt', 'Gloss Lamination', 'Gloss Sealer'] },
	{ feature_name: 'Textured Embossed Finish', option_names: ['Yes', 'No'] },
	{ feature_name: 'Tissue Paper Packing', option_names: ['Yes', 'No'] }
])
populate_feature_options_products('Tissue Paper', [
	{ feature_name: 'Register Print', option_names: ['Yes', 'No'] }
])
populate_feature_options_products('Ribbon', [
	{ feature_name: 'Material', option_names: ['Double Faced Polyester Satin', 'Polyester Grossgrain'] },
	{ feature_name: 'Print', option_names: ['Screen', 'Foil', 'Cold Foil', 'Puffy'] },
	{ feature_name: 'Register Print', option_names: ['Yes', 'No'] }
])
populate_feature_options_products('Labels', [
	{ feature_name: 'Material', option_names: ['Vinyl', 'Art Paper'] },
	{ feature_name: 'Foils', option_names: ['Yes', 'No'] }
])

# Foil is text for Gift Box
# Foils is options Yes, No for Labels
# Material is text Kraft Paper Carrier Bag, Luxury Paper Carrier Bag, Gift Box, Tissue Paper
# Material is options Plastic Carrier Bag, Ribbon, Labels
