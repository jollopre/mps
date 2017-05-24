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
		@order_item.features.each do |f|
			fv = self.find_feature_value_for(f)
			if !fv.nil?
				text("#{f.feature_label.name}: #{fv.formatted_value()}")
			end
		end
	end

	def find_feature_value_for(feature)
		index = @order_item.feature_values.index { |fv| fv.feature == feature }
		if !index.nil?
			return @order_item.feature_values[index]
		else
			return nil
		end
	end

	def render_pdf
		header()
		body()
		render()
	end
end