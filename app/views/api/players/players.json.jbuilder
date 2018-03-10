json.success true
json.players do
  json.array! @players do |player|
    json.id player.id
    json.first_name player.first_name
    json.last_name player.last_name
    json.rating player.rating
  end
end