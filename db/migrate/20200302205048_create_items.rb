class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      #t.integer 'id'
      t.string 'name'
      t.string 'description'
      t.float 'price'

      t.integer 'shop_id'

      t.timestamps
    end
  end
end
