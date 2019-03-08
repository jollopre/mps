class AddAddressCityPostCodeCountryToSuppliers < ActiveRecord::Migration[5.2]
  def change
    add_column(:suppliers, :address, :string)
    add_column(:suppliers, :city, :string)
    add_column(:suppliers, :postcode, :string)
    add_column(:suppliers, :country, :string)
  end
end
