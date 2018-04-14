require 'test_helper'

class EnquiriesControllerTest < ActionDispatch::IntegrationTest
  setup do
  	# Following instance variables are created according to the values stored in fixtures quotations.yml, etc ...
  	@quotation = quotations(:quotation1)
  	@product = products(:product1)
  	@enquiry = enquiries(:enquiry1)
    @user = users(:user1)
  end

  # GET /quotations/:quotation_id/enquiries
  test 'should get success at index action' do
  	get quotation_enquiries_path(@quotation.id), headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :ok
  end

  # POST /quotations/:quotation_id/enquiries
  test 'should get bad request for missing parameters at create action' do
  	post quotation_enquiries_path(@quotation.id), params: {enquiry: {}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :bad_request
  end
  test 'should get bad request for invalid data at create action (quantity as float)' do
  	post quotation_enquiries_path(@quotation.id), params: {enquiry: {product_id: @product.id, quantity: 1.2}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :bad_request
  end
  test 'should get bad request for invalid data at create action (quantity as string)' do
  	post quotation_enquiries_path(@quotation.id), params: {enquiry: {product_id: @product.id, quantity: 'aaa'}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :bad_request
  end
  test 'should get created for valid data at create action (quantity param missed)' do
  	post quotation_enquiries_path(@quotation.id), params: {enquiry: {product_id: @product.id}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :created
  end
  test 'should get created for valid data at create action (quantity param as integer)' do
  	post quotation_enquiries_path(@quotation.id), params: {enquiry: {product_id: @product.id, quantity: 2}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :created
  end

  # GET /enquiries/:id
  test 'should get not found at show action' do
  	get enquiry_path(10000), headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :not_found
  end
  test 'should get no content at show action' do
  	get enquiry_path(@enquiry.id), headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :ok
  end
  
  # PATCH/PUT /enquiries/:id
  test 'should get bad request for missing parameters at update action' do
  	put enquiry_path(@enquiry.id), params: {enquiry: {}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :bad_request
  end
  test 'should get not found at update action' do
  	put enquiry_path(10000), params: {enquiry: {quantity: 2}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :not_found
  end
  test 'should get bad request for invalid data at update action (quantity as string)' do
  	put enquiry_path(@enquiry.id), params: {enquiry: {quantity: 'aaa'}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :bad_request
  end
  test 'should get bad request for a quantity less than zero' do
    put enquiry_path(@enquiry.id), params: {enquiry: { quantity: -1 }}, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response(:bad_request)
    put enquiry_path(@enquiry.id), params: {enquiry: { quantity2: -1 }}, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response(:bad_request)
    put enquiry_path(@enquiry.id), params: {enquiry: { quantity3: -1 }}, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response(:bad_request)
  end
  test 'should get success at update action' do
  	put enquiry_path(@enquiry.id), params: {enquiry: {quantity: 1000}}, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :ok
    put enquiry_path(@enquiry.id), params: {enquiry: {quantity2: 1000}}, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :ok
    put enquiry_path(@enquiry.id), params: {enquiry: {quantity3: 1000}}, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :ok
    put enquiry_path(@enquiry.id), params: {enquiry: { quantity: 1000, quantity2: 1000, quantity3: 1000 }}, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :ok
  end
  # GET /api/enquiries/:id/export
  test 'should get not found at export action' do
    get export_enquiry_path(10000), headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :not_found
  end
  test 'should get success at export action' do
    get export_enquiry_path(@enquiry.id), headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :ok
  end
  test 'should get pdf content type at export action' do
    get export_enquiry_path(@enquiry.id), headers: { 'Authorization' => 'Token token='+@user.token }
    assert_equal(Mime::Type.lookup_by_extension(:pdf), response.header['Content-type'])
  end
end
