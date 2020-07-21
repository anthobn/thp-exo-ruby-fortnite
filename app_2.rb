require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "Veuillez spécifier votre prénom :"
print '> '

human1 = HumanPlayer.new(gets.chomp)
player1 = Player.new('Josiane')
player2 = Player.new('José')
enemies = [player1, player2]

while human1.life_points > 0 && (player1.life_points > 0 && player2.life_points > 0)
  human1.show_state
  puts "Quelle action veux-tu effectuer ?"
  puts ""
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts ""
  puts "Attaquer un joueur en vue :"
  print "0 - "
  print "#{player1.show_state}"
  print "1 - "
  print "#{player2.show_state}"
  puts ""
  puts "Entrez une commande :"
  print '> '
  input = gets.chomp.to_s

  if input == "a"
    human1.search_weapon
  elsif input == "s"
    human1.search_health_pack
  elsif input == "0"
    human1.attacks(player1)
  elsif input == "1"
    human1.attacks(player2)
  end

  puts "Les autres joueurs t'attaquent !"
  enemies.each do |player|
    player.attacks(human1) if (player.life_points > 0)
  end
end

puts "Fin du jeu"
(human1.life_points > 0) ? (puts "BRAVO ! TU AS GAGNE !") : (puts "Loser ! Tu as perdu !")