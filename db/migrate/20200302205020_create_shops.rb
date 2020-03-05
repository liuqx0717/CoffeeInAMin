class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops  do |t|
      # t.integer 'id'
      t.string 'name'
      t.string 'address'
      t.string 'description'

      t.integer 'owner_id'

      t.timestamps
    end
  end
end
