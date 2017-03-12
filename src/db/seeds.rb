# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

def populate_products(values)
	values.each do |value|
		Product.create({ name: value })
	end
end

def populate_feature_labels(values)
	values.each do |value|
		FeatureLabel.create({ name: value })
	end
end

def populate_features(product_name, values)
	def populate_options(feature, values)
		values.each do |value|
			FeatureOption.create({ name: value, feature: feature })
		end
	end
	product = Product.find_by(name: product_name)
	values.each do |value|
		label = FeatureLabel.find_by({ name: value[:feature_label]})
		feature = Feature.create({ feature_type: value[:feature_type], product: product, feature_label: label })
		populate_options(feature, value[:feature_options]) if !value[:feature_options].nil?
	end
end

populate_products([
	'Plastic Carrier Bag',
	'Kraft Paper Carrier Bag',
	'Luxury Paper Carrier Bag',
	'Gift Box',
	'Tissue Paper',
	'Ribbon',
	'Labels',
	'Garment Covers',
	'Jewelery Boxes',
	'Fabric Pouch'
])

populate_feature_labels([
	'Bag Style',
	'Handle Style',
	'Handle Colour',
	'Handle Material',
	'Turnover Top',
	'Material',
	'Colour',
	'GSM',
	'Micron',
	'Film Colour',
	'Width',
	'Height',
	'Length',
	'Depth',
	'No. Printed Colours (out)',
	'No. Printed Colours (in)',
	'No. Printed Sides',
	'% Ink Coverage (in)',
	'% Ink Coverage (out)',
	'Finish (in)',
	'Finish (out)',
	'Card Base',
	'Handle Tie Style',
	'Textured Embossed Finish',
	'Tissue Paper Packing',
	'Create Fold In Base',
	'Box Style',
	'Thumbcuts',
	'Insert',
	'Foil',
	'Packing (reams)',
	'Print',
	'Register Print',
	'Foils'
])

populate_features('Plastic Carrier Bag', [
	{feature_label: 'Bag Style', feature_type: 'options', feature_options: ['Bottom Gusset', 'Side Gusset', 'Block Bottom'] },
	{feature_label: 'Handle Style', feature_type: 'options', feature_options: ['Patch', 'Side Gusset', 'Block Bottom', 'Vest', 'Clip Close', 'TOT (Turnover Top)'] },
	{feature_label: 'Handle Colour', feature_type: 'text' },
	{feature_label: 'Turnover Top', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Material', feature_type: 'options', feature_options: ['Hdpe', 'Ldpe'] },
	{feature_label: 'Micron', feature_type: 'number' },
	{feature_label: 'Film Colour', feature_type: 'text' },
	{feature_label: 'Width', feature_type: 'number' },
	{feature_label: 'Height', feature_type: 'number' },
	{feature_label: 'Depth', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: 'No. Printed Sides', feature_type: 'number' },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: 'Finish (out)', feature_type: 'options', feature_options: ['Matt', 'Gloss Laquer'] },
	{feature_label: 'Card Base', feature_type: 'options', feature_options: ['Yes', 'No'] }
])
populate_features('Kraft Paper Carrier Bag', [
	{feature_label: 'Bag Style', feature_type: 'options', feature_options: ['SOS (Self Opening Satchel', 'Unstrung'] },
	{feature_label: 'Handle Style', feature_type: 'options', feature_options: ['Twisted Paper', 'Rope', 'Sack'] },
	{feature_label: 'Handle Colour', feature_type: 'text' },
	{feature_label: 'Handle Material', feature_type: 'text' },
	{feature_label: 'Turnover Top', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Material', feature_type: 'text' },
	{feature_label: 'Colour', feature_type: 'text' },
	{feature_label: 'GSM', feature_type: 'number' },
	{feature_label: 'Width', feature_type: 'number' },
	{feature_label: 'Height', feature_type: 'number' },
	{feature_label: 'Depth', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: 'No. Printed Sides', feature_type: 'number' },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: 'Finish (out)', feature_type: 'options', feature_options: ['Matt', 'Gloss Laquer'] },
	{feature_label: 'Card Base', feature_type: 'options', feature_options: ['Yes', 'No'] },
])
populate_features('Luxury Paper Carrier Bag', [
	{feature_label: 'Bag Style', feature_type: 'options', feature_options: ['Luxury Art Carrier'] },
	{feature_label: 'Handle Style', feature_type: 'options', feature_options: ['Rope', 'Ribbon', 'Die Cut'] },
	{feature_label: 'Handle Colour', feature_type: 'text' },
	{feature_label: 'Handle Material', feature_type: 'text' },
	{feature_label: 'Handle Tie Style', feature_type: 'options', feature_options: ['Knotted', 'Glued'] },
	{feature_label: 'Material', feature_type: 'text' },
	{feature_label: 'Colour', feature_type: 'text' },
	{feature_label: 'GSM', feature_type: 'number'},
	{feature_label: 'Width', feature_type: 'number' },
	{feature_label: 'Height', feature_type: 'number' },
	{feature_label: 'Depth', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (in)', feature_type: 'number' },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: 'Finish (out)', feature_type: 'options', feature_options: ['Matt', 'Gloss Lamination'] },
	{feature_label: 'Card Base', feature_type: 'options', feature_options: ['Yes'] },
	{feature_label: 'No. Printed Sides', feature_type: 'number' },
	{feature_label: 'Textured Embossed Finish', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Tissue Paper Packing', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Create Fold In Base', feature_type: 'options', feature_options: ['Yes', 'No'] }
])
populate_features('Gift Box', [
	{feature_label: 'Box Style', feature_type: 'options', feature_options: ['Rigid', 'Magnetic Folding', 'Folding Double Walled', 'Tuck in lid', 'Base Carton'] },
	{feature_label: 'Handle Style', feature_type: 'options', feature_options: ['Two Piece Box', 'Fold Flat Box'] },
	{feature_label: 'Thumbcuts', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Material', feature_type: 'text' },
	{feature_label: 'Colour', feature_type: 'text' },
	{feature_label: 'GSM', feature_type: 'number' },
	{feature_label: 'Width', feature_type: 'number' },
	{feature_label: 'Length', feature_type: 'number' },
	{feature_label: 'Depth', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (in)', feature_type: 'number' },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: '% Ink Coverage (in)', feature_type: 'number' },
	{feature_label: 'Finish (out)', feature_type: 'options', feature_options: ['Matt', 'Gloss Lamination'] },
	{feature_label: 'Finish (in)', feature_type: 'options', feature_options: ['Matt', 'Gloss Lamination', 'Gloss Sealer'] },
	{feature_label: 'Insert', feature_type: 'text', feature_options: [] },
	{feature_label: 'No. Printed Sides', feature_type: 'number' },
	{feature_label: 'Textured Embossed Finish', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Tissue Paper Packing', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Foil', feature_type: 'text' }
])
populate_features('Tissue Paper', [
	{feature_label: 'Material', feature_type: 'text' },
	{feature_label: 'Colour', feature_type: 'text' },
	{feature_label: 'GSM', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: 'Register Print', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: 'Packing (reams)', feature_type: 'number' }
])
populate_features('Ribbon', [
	{feature_label: 'Material', feature_type: 'text' },
	{feature_label: 'Colour', feature_type: 'text' },
	{feature_label: 'Print', feature_type: 'options', feature_options: [] },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: 'Register Print', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: 'Packing (reams)', feature_type: 'number' }
])
populate_features('Labels', [
	{feature_label: 'Material', feature_type: 'options', feature_options: ['Vinyl', 'Art Paper'] },
	{feature_label: 'Colour', feature_type: 'text' },
	{feature_label: 'GSM', feature_type: 'number' },
	{feature_label: 'No. Printed Colours (out)', feature_type: 'number' },
	{feature_label: '% Ink Coverage (out)', feature_type: 'number' },
	{feature_label: 'Foils', feature_type: 'options', feature_options: ['Yes', 'No'] },
	{feature_label: 'Packing (reams)', feature_type: 'number' }
])

=begin
populate_features('', [
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] },
	{feature_label: '', feature_type: '', feature_options: [] }
])
=end