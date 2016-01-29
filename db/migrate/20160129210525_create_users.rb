class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :scrum_lead_date
      t.references :team
      t.timestamps null: false
    end
  end
end
