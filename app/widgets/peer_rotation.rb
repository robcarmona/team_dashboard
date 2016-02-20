class PeerRotation < WidgetBase

  def initialize
    # TODO
  end

  # Get current rotation
  # TODO: Refactor query calls
  # [ { :user => @user, :reviewer => @user2  }, {...} ]
  def self.get_current_rotation
    rotation_data = []
    users = User.where(team_id: Team::RUBY_PROD)

    user_store = Hash.new
    begin_date = DateTime.now.beginning_of_week - 1.day
    data = WidgetDatum.where("widget_id = ?", Widget::PEER_ROTATION)
      .where(created_at: begin_date..Time.now)
      .limit(users.count)
      .order(created_at: :desc)

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

  # Updates rotation based on team member count
  def self.update_rotation
    users = User.where(team_id: Team::RUBY)

    ids = users.ids
    global_ids = ids

    begin_date = (DateTime.now.beginning_of_week - (ids.count - 1).weeks) - 1.day

    # For each User, retrieve history of lastest complete rotations
    # Get current pool of users and create new rotation
    ids.each_with_index do | user_id, index |
      assignments = WidgetDatum.where("widget_id = ?", Widget::PEER_ROTATION)
        .where(created_at: begin_date..Time.now)
        .where("data like ?", "%\"user_id\":#{user_id}%")
        .limit(ids.count - 1)

      # Remove current user from pool (cannot assign self as review buddy)
      pool = global_ids - [user_id]
      remove_from_pool = assignments.map { |d| d.get_data["reviewer_id"] }

      # Create new pool based on previous assignment history
      # If previous history assignments all have been filled, start over from inital pool
      new_pool = pool - remove_from_pool
      new_reviewer = new_pool.sample
      new_reviewer = pool.sample unless new_reviewer.present?

      # Prevent scneario where pool is closed and last user cannot be paired
      if index == ids.length - 2
        if [ids.last] == global_ids - [new_reviewer]
          new_reviewer = ids.last
        end
      end

      # Update global pool once taken
      global_ids = global_ids - [new_reviewer]

      # Update database
      data = { :user_id => user_id, :reviewer_id => new_reviewer }
      WidgetDatum.create!({ widget_id: Widget::PEER_ROTATION, data: data.to_json })
      puts "Assigned user: #{user_id} reviewer: #{new_reviewer}"
    end

  end

end
