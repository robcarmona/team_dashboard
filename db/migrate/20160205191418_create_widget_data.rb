class CreateWidgetData < ActiveRecord::Migration
  def change
    create_table :widget_data do |t|
      t.references :widget
      t.text :data
      t.timestamps null: false
    end
  end
end
