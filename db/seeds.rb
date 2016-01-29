Team.create!([
  {name: "Ruby Team"}
  ])

User.create!([
  {name: "Alex Myers", email: "amyers@enspiresoftware.com", scrum_lead_date: Date.today, team_id: 1},
  {name: "Eric Fox", email: "efox@enspiresoftware.com", scrum_lead_date: Date.today - 1.day, team_id: 1},
  {name: "Mike Richards", email: "mrichards@enspiresoftware.com", scrum_lead_date: Date.today - 2.day, team_id: 1},
  {name: "Robert Carmona", email: "rcarmona@enspiresoftware.com", scrum_lead_date: Date.today - 3.day, team_id: 1}
])
