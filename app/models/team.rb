class Team < ActiveRecord::Base
  has_many :users
  RUBY_INFRA = 1
  RUBY_PROD = 2
  DOT_NET = 3
end
