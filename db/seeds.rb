Team.create!([
  {name: "Ruby Team"}
])

User.create!([
  {name: "Alex Myers", email: "amyers@enspiresoftware.com", team_id: 1},
  {name: "Eric Fox", email: "efox@enspiresoftware.com", team_id: 1},
  {name: "Mike Richards", email: "mrichards@enspiresoftware.com", team_id: 1},
  {name: "Robert Carmona", email: "rcarmona@enspiresoftware.com", team_id: 1}
])

Widget.create!([
  {name: "Peer Rotation", description: "Randomly sets the peer review buddy of each person of the team. Scheduled to automatically change each Monday."},
  {name: "Scrum Leader", description: "Randomly sets the team leader of the scrum each day. Scheduled to automatically change each morning."},
  {name: "Pull Requests", description: "Get all open pull requests from Github for the team."}
])

# create a widget setting for each widget for each user
(1..4).each do |m|
  (1..3).each do |n|
    WidgetSetting.create!([
      {user_id: m, widget_id: n, enabled: true, data: ""}
    ])
  end
end

# create widget data for each widget
(1..3).each do |o|
  WidgetDatum.create!([
    {widget_id: o, data: ""},
  ])
end
