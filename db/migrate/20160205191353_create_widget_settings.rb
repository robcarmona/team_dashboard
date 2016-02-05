class CreateWidgetSettings < ActiveRecord::Migration
  def change
    create_table :widget_settings do |t|
      t.references :user
      t.references :widget
      t.boolean :enabled
      t.string :data
      t.timestamps null: false
    end
  end
end
