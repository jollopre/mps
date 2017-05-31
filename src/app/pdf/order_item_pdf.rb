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
		@order_item.feature_values.each do |fv|
			text("#{fv.feature.feature_label.name}: #{fv.value_to_feature_type(true)}")
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