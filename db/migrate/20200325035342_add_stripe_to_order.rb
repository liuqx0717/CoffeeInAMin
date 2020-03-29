class AddStripeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :card_token, :string
    add_column :orders, :stripe_email, :string
  end
end
