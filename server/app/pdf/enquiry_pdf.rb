class EnquiryPdf
	include Prawn::View

	def initialize(enquiry)
		@enquiry = enquiry
	end

	def header
		stroke_horizontal_rule
		pad(5) {
			font_size(24) { text("Order Item: #{@enquiry.id}") };
			font_size(24) { text("Quotation: #{@enquiry.quotation.id}") };
			font_size(24) { text("Product: #{@enquiry.product.name}") }
		}
		stroke_horizontal_rule
		move_down(10)
	end

	def body
		any_value=false
		@enquiry.feature_values.each do |fv|
			if fv.feature.option? && fv.value.present?
				any_value ||= true
				text("<b>#{fv.feature.feature_label.name}:</b> #{fv.feature.get_feature_option_for(fv.value.to_i)}",
					:inline_format => true)
			else
				r=fv.value_to_feature_type()
				if r.present?
					any_value ||= true
					text("<b>#{fv.feature.feature_label.name}:</b> #{fv.value_to_feature_type()}",
						:inline_format => true)
				end
			end
		end
		if !any_value
			text("There are no values associated to this order item")
		end
	end

	def find_feature_value_for(feature)
		return @enquiry.feature_values.find { |fv| fv.feature == feature }
	end

	def render_pdf
		header()
		body()
		render()
	end
end