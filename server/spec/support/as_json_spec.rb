require 'spec_helper'

RSpec.shared_examples "#as_json" do |expected_keys|
  it "returns the expected_keys passed" do
    actual_keys = subject.keys
    expect(actual_keys).to match_array(expected_keys)
  end
end
