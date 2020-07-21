class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def compute_damage
    return rand(1..6)
  end

  def attacks(player)
    puts "Le joueur #{@name} attaque le joueur #{player.name}"
    random = compute_damage
    player.gets_damage(random)
    puts "#{@name} a attaqué le joueur #{player.name} qui a perdu #{random} points de vies"
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage)
    @life_points -= damage

    @life_points <= 0 ? (puts "Le joueur #{@name} a été tué !") : (show_state)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level
  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def search_weapon
    weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{weapon_level}"
    (weapon_level > @weapon_level) ? (@weapon_level = weapon_level) : (puts "M@*#$... elle n'est pas mieux que ton arme actuelle...")
  end

  def search_health_pack
    health_level = rand(1..6)
    if health_level == 1
      puts "Tu n'as rien trouvé... "
    elsif health_level > 1 && health_level < 6
      (@life_points + 50 > 100) ? (@life_points = 100) : (@life_points += 50)
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      (@life_points + 80 > 100) ? (@life_points = 100) : (@life_points += 80)
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end
end