RSpec.shared_examples "bad_request" do
  it 'returns a bad_request' do
    expect(response).to have_http_status(:bad_request)
  end

  it 'all errors have 400 status' do
    expect(parsed_response['errors']).to all(include('status' => 400))
  end
end

RSpec.shared_examples "unprocessable_entity" do
  it 'returns unprocessable_entity' do
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'all errors have 422 status' do
    expect(parsed_response['errors']).to all(include('status' => 422))
  end
end

RSpec.shared_examples "not_found" do
  it 'returns not_found' do
    expect(response).to have_http_status(:not_found)
  end

  it 'all errors have 404 status' do
    expect(parsed_response['errors']).to all(include('status' => 404))
  end
end
