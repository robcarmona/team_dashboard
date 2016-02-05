class Team < ActiveRecord::Base
  has_many :users
  RUBY = 1
end
