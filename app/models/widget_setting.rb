class WidgetSetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :widget
end
