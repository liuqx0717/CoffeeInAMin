class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, {id: false} do |t|
      t.integer 'id'
      t.string 'email'
      t.string 'name'
      t.string 'password'

      t.timestamps
    end
  end
end
