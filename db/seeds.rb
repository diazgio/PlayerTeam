Player.destroy_all
PlayerSkill.destroy_all


#'defender'
10.times do |i|
  player = Player.create(name: "Player #{i}", position: "defender")
  PlayerSkill.create(player: player, skill: "defense", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "attack", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "strength", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "speed", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "stamina", value: rand(1..100))
end

#'midfielder'
10.times do |i|
  player = Player.create(name: "Player #{i + 10}", position: "midfielder")
  PlayerSkill.create(player: player, skill: "defense", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "attack", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "strength", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "speed", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "stamina", value: rand(1..100))
end

#'forward'
10.times do |i|
  player = Player.create(name: "Player #{i + 20}", position: "forward")
  PlayerSkill.create(player: player, skill: "defense", value: rand(1..100))
  # PlayerSkill.create(player: player, skill: "attack", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "strength", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "speed", value: rand(1..100))
  PlayerSkill.create(player: player, skill: "stamina", value: rand(1..100))
end

puts "Players created"