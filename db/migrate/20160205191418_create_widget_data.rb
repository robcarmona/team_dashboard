class CreateWidgetData < ActiveRecord::Migration
  def change
    create_table :widget_data do |t|
      t.references :widget
      t.string :data
      t.timestamps null: false
    end
  end
end
