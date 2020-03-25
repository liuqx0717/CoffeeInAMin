class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops  do |t|
      # t.integer 'id'
      t.string 'name'
      t.string 'address'
      t.string 'description'
      t.float 'latitude'
      t.float 'longitude'
      t.integer 'owner_id'

      t.timestamps
    end
  end
end


# rails g migration add_coordinates_to_shops latitude:float longitude:float
# rake db:migrate