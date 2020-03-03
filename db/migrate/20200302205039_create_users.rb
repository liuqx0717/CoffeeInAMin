class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      #t.integer 'id'
      t.string 'email'
      t.string 'name'
      t.string 'password'
      t.integer 'type'    # 0: client   1: merchant

      t.timestamps
    end
  end
end
