class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :subdomain
      t.string :password
      t.string :api_key

      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
    add_index :users, :username, 						 unique: true
    add_index :users, :subdomain, 					 unique: true
    add_index :users, :api_key, 					   unique: true
  end
end
