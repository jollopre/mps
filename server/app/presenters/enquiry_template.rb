class EnquiryTemplate
  include Prawn::View

  attr_reader :enquiry
  attr_reader :document
  FONT_SIZE = 8

  def initialize(enquiry)
    @enquiry = enquiry
    @document = Prawn::Document.new(:page_size => 'A4')
    define_grid(columns: 12, rows: 8, gutter: 10)
    font_size(FONT_SIZE)
    header
    sub_header
    body
    footer
  end

  private

  def base_path
    Rails.root.to_s
  end
  
  def header
    grid([0,0], [1,11]).bounding_box do
      transparent(0.5) { stroke_bounds }
      grid([0,0],[0,0]).bounding_box do
        pad_top(5) do
          indent(5) do
            image("#{base_path}/app/assets/images/logo.png")
          end
        end
      end
      grid([0,1],[0,5]).bounding_box do
        pad_top(10) do
          indent(10) do
            text("MARSHALL PACKAGING Ltd")
            text("OFFICE S2, 11 MARITIME STREET")
            text("EDINBURGH, EH6 6SB")
          end
        end
      end
      grid([0,5],[0,8]).bounding_box do
        pad_top(40) do
          font_size(18)
          text("ENQUIRY", style: :bold)
          font_size(FONT_SIZE)
        end
      end
      grid([1,0],[1,1]).bounding_box do
        indent(10) do
          text("Date:", style: :bold)
          text("Customer:", style: :bold)
          text("Ref No:", style: :bold)
        end
      end
      grid([1,2],[1,5]).bounding_box do
        text("#{enquiry.updated_at}")
        text("#{company_name}")
        text("#{reference}")
      end
      grid([1,8],[1,9]).bounding_box do
        text("Enquiry No:", style: :bold)
        text("Contact:", style: :bold)
        text("Email:", style: :bold)
      end
      grid([1,10],[1,11]).bounding_box do
        text("#{enquiry.id}")
        text("#{contact_name}")
        text("#{contact_email}")
      end
    end
  end
  
  def sub_header
    grid([2,0],[2,11]).bounding_box do
      grid([0,6],[0,11]).bounding_box do
        pad_top(10) do
          text("Delivery Address:", style: :bold, align: :center)
          text("#{address}", align: :center)
          transparent(0.5){ stroke_bounds }
        end
      end
    end
  end

  def body
    grid([3,0],[6,11]).bounding_box do
      transparent(0.5){ stroke_bounds }
      grid([0,4],[3,11]).bounding_box do
        enquiry_pairs.each do |pair|
          pad_top(10) do
            text("<b>#{pair[:label]}</b>: #{pair[:value]}", inline_format: true)
          end
        end
      end
    end
  end

  def footer
    grid([7,0],[7,11]).bounding_box do
    end
  end
  
  private

  def enquiry_pairs
    pairs = [
      { label: 'Design', value: enquiry.product.name },
      { label: 'Quantity', value: "#{enquiry.quantity} / #{enquiry.quantity2} / #{enquiry.quantity3}" }
    ]
    enquiry.feature_values.reduce(pairs) do |acc, fv|
      value = fv.value
      if value.present?
        pair = { label: fv.feature.feature_label.name }
        if fv.feature.option?
          pair.merge!({ value: fv.feature.get_feature_option_for(value.to_i).name })
        else
          pair.merge!({ value: value })
        end
        acc << pair
      end
      acc
    end
  end

  def reference
    enquiry.quotation.customer.reference
  end

  def company_name
    enquiry.quotation.customer.company_name
  end

  def address
    enquiry.quotation.customer.address
  end

  def contact_name
    ENV['CONTACT_NAME'] || ''
  end

  def contact_email
    ENV['CONTACT_EMAIL'] || ''
  end
end
