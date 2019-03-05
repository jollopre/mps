class AddCityPostCodeCountryToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column(:customers, :city, :string)
    add_column(:customers, :postcode, :string)
    add_column(:customers, :country, :string)
  end
end
