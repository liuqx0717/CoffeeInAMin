class AddQrCodeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :qr_code, :string
  end
end
