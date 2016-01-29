class PeerRotation < ActiveRecord::Base
  belongs_to :user
  belongs_to :peer_user, :class_name => "User"
end
