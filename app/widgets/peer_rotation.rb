class PeerRotation < WidgetBase

  def initialize
    # TODO
  end

  # Get current rotation
  # TODO: Currently retrieves all from db
  # TODO: Refactor query calls
  # [ user => peer_reviewer ]
  def self.get_current_rotation
    rotation_data = []

    user_store = Hash.new
    data = WidgetDatum.where("widget_id = ? AND created_at >= ?", Widget::PEER_ROTATION, Time.now - 5.days)

    data.each do | info |
      match = Hash.new

      # Cache users for less query calls
      user_store[info.get_data["user_id"]] = User.find(info.get_data["user_id"]) unless user_store.has_key?(info.get_data["user_id"])
      user_store[info.get_data["reviewer_id"]] = User.find(info.get_data["reviewer_id"]) unless user_store.has_key?(info.get_data["reviewer_id"])

      match[:user] = user_store[info.get_data["user_id"]]
      match[:reviewer] = user_store[info.get_data["reviewer_id"]]
      rotation_data.push(match)
    end

    return rotation_data
  end

end
