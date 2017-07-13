class OrderItemPdf
	include Prawn::View

	def initialize(order_item)
		@order_item = order_item
	end

	def header
		stroke_horizontal_rule
		pad(5) {
			font_size(24) { text("Order Item: #{@order_item.id}") };
			font_size(24) { text("Order: #{@order_item.order.id}") };
			font_size(24) { text("Product: #{@order_item.product.name}") }
		}
		stroke_horizontal_rule
		move_down(10)
	end

	def body
		any_value=false
		@order_item.feature_values.each do |fv|
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
		return @order_item.feature_values.find { |fv| fv.feature == feature }
	end

	def render_pdf
		header()
		body()
		render()
	end
end