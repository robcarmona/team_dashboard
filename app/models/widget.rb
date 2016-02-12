class Widget < ActiveRecord::Base
  has_many :widget_settings
  has_many :widget_datum
  PEER_ROTATION = 1
  SCRUM_LEADER  = 2
  PULL_REQUESTS = 3
end
