class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, {id: false} do |t|
      t.integer 'id'
      t.datetime 'date_created'
      t.string 'name'
      t.string 'description'
      t.float 'price'
      
      t.integer 'shop_id'

      t.timestamps
    end
  end
end
