class Game
  attr_accessor :human_player, :enemies

  def initialize(name)
    @enemies = [player1 = Player.new('Josiane'), player2 = Player.new('José'), player3 = Player.new('Géraldine'), player4 = Player.new('Simone')]
    @human_player = HumanPlayer.new(name)
  end

  def kill_player(player)
    @enemies.delete(player)
  end

  def is_still_ongoing?
    if @human_player.life_points > 0 && @enemies.length > 0
      return true
    end
    return false
  end

  def show_players
    puts "#{@human_player.name} a #{@human_player.life_points} points de vies restants"
    puts "Il y a encore #{@enemies.length} ennemis restants"
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "Attaquer un joueur en vue :"

    @enemies.each_with_index do |player, index|
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
      @human_player.attacks(@enemies[input.to_i])
    end
    kill_player(@enemies[input.to_i]) if @enemies[input.to_i].life_points < 1
  end

  def enemies_attack
    puts "Les autres joueurs t'attaquent !"
    @enemies.each do |player|
      player.attacks(@human_player) if (player.life_points > 0)
    end
  end

  def end
    puts "Fin du jeu"
    (@human_player.life_points > 0) ? (puts "BRAVO ! TU AS GAGNE !") : (puts "Loser ! Tu as perdu !")
  end
end