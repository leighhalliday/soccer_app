json.(@team, :id, :name, :updated_at)

json.league do
  json.id @team.league.id
  json.name @team.league.name
  json.slug @team.league.slug
  json.updated_at @team.league.updated_at
end

json.players @team.players do |player|
  json.(player, :id, :name, :nationality, :nickname, :jersey_number, :position, :updated_at)
end