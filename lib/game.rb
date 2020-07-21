class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(name)
    @enemies_in_sight = []
    @human_player = HumanPlayer.new(name)
    @players_left = 10
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    if @human_player.life_points > 0 && @enemies_in_sight.length > 0
      return true
    end
    return false
  end

  def show_players
    puts "#{@human_player.name} a #{@human_player.life_points} points de vies restants"
    puts "Il y a encore #{@enemies_in_sight.length} ennemis restants"
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "Attaquer un joueur en vue :"

    @enemies_in_sight.each_with_index do |player, index|
      print "#{index} - "
      print "#{player.show_state}"
    end

    puts "Entrez une commande :"
    print '> '
  end

  def menu_choice(input)
    if input == "a"
      @human_player.search_weapon
    elsif input == "s"
      @human_player.search_health_pack
    else
      @human_player.attacks(@enemies_in_sight[input.to_i])
    end
    kill_player(@enemies_in_sight[input.to_i]) if @enemies_in_sight[input.to_i].life_points < 1
  end

  def enemies_attack
    puts "Les autres joueurs t'attaquent !"
    @enemies_in_sight.each do |player|
      player.attacks(@human_player) if (player.life_points > 0)
    end
  end

  def end
    puts "Fin du jeu"
    (@human_player.life_points > 0) ? (puts "BRAVO ! TU AS GAGNE !") : (puts "Loser ! Tu as perdu !")
  end

  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      return "Tous les joueurs sont déjà en vue"
    end
    random = rand(1..6)
    
    if random == 1
      puts 'Le résultat du dé ne permet pas de rajouter un nouveau joueur'
    elsif random > 1 && random < 5
      puts 'Suite au résultat du dé, un nouveau joueur arrive sur le plateau'
      rand_player = rand(1234..9999)
      @enemies_in_sight << Player.new("player_#{rand_player}")
    else
      puts 'Suite au résultat du dé, deux nouveaux joueurs arrivent sur le plateau'
      rand_player1 = rand(1234..9999)
      rand_player2 = rand(1234..9999)
      @enemies_in_sight << Player.new("player_#{rand_player1}")
      @enemies_in_sight << Player.new("player_#{rand_player2}")
    end
  end
end