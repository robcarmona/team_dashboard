class Widget < ActiveRecord::Base
  has_many :widget_settings
  has_many :widget_datum
end
