class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :description
      t.string :table
      t.timestamps null: false
    end
  end
end
