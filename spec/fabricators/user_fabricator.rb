Fabricator(:user) do
  player_name { sequence(:player_name) { |i| "username#{i}" } }
  token { "Foo"}
  ada_id { 1}
end
