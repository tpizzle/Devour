json.users(@users) do |user|
  json.email user.email.scan(/[^@]+/).first
  json.num_owned user.owned_decks.length
  json.num_responses user.responses.length
  json.score user.score
end
