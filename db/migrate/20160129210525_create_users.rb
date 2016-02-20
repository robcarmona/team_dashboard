class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :team
      t.string :github_token
      t.string :github_username
      t.integer :github_id
      t.timestamps null: false
    end
  end
end
