
##
# Represents a general item in the game.

class Item
  attr_reader :name, :strength, :power, :description

  ##
  # Initializes a new item with the specified attributes.

  def initialize(name, strength, power, description)
    @name = name
    @strength = strength
    @power = power
    @description = description
  end

  ##
  # Displays meaningful item's attributes.

  def display
    puts "#{name}: #{description}"
    puts "Attributes:"

    if strength != 0
      puts "This item will always add #{strength} to your strength."
    end

    if power != 0
      puts "This item will always add #{power} to your power."
    end
  end

  
end

##
# Represents a weapon item in the game

class Weapon < Item
  attr_reader :vs_player, :vs_monster, :vs_ghost, :vs_demon

  ##
  # Initializes a new item with the specified attributes.

  def initialize(name, strength, power, description, vs_player, vs_monster, vs_ghost, vs_demon)
    super(name, strength, power, description)
    @vs_player = vs_player
    @vs_monster = vs_monster
    @vs_ghost = vs_ghost
    @vs_demon = vs_demon
  end

  ##
  # Displays meaningful weapon's attributes.

  def display
    super
    
    if vs_monster != 0
      puts "In a fight with a monster, it adds #{vs_monster} to your strength."
    end

    if vs_ghost != 0
      puts "In a fight with a ghost, it adds #{vs_ghost} to your strength."
    end

    if vs_demon != 0
      puts "In a fight with a demon, it adds #{vs_demon} to your strength."
    end
  end

end

##
# Represents an armor item in the game

class Armor < Item
  attr_reader :protection_percent

  ##
  # Initializes a new armor with the specified attributes.

  def initialize(name, strength, power, description, protection_percent)
    super(name, strength, power, description)
    @protection_percent = protection_percent
  end

  ##
  # Return information if armor protected character.

  def try_to_protect
    random_value = rand(1..100)
    if random_value <= protection_percent
      true
    else
      false
    end
  end

  ##
  # Displays meaningful armor's attributes.

  def display
    super
    puts "Has a #{protection_percent}% to save you from losing HP."
  end
end


=begin
weapons = [
  Weapon.new("Sword of Valor", 0, 0, "A noble sword forged with honor and imbued with the spirit of valor.", 2, 2, 1, 1),
  Weapon.new("Darkblade", 1, 1, "A wickedly sharp blade infused with dark magic, capable of cutting through even the strongest defenses.", 3, 2, 1, 1),
  Weapon.new("Elven Bow", 0, 0, "A finely crafted bow of elven design, known for its precision and accuracy.", 1, 1, 2, 1),
  Weapon.new("Hammer of Thunder", 0, 0, "A mighty hammer said to harness the power of thunder itself, striking fear into the hearts of enemies.", 2, 3, 1, 1),
  Weapon.new("Staff of the Magi", 2, 1, "A mystical staff passed down through generations of powerful wizards, granting mastery over the arcane arts.", 0, 0, 3, 2),
  Weapon.new("Frostbite Dagger", 1, 1, "A dagger enchanted with icy magic, capable of freezing foes with a single strike.", 1, 1, 1, 2),
  Weapon.new("Venomous Whip", 1, 1, "A deadly whip coated with potent venom, inflicting both physical and toxic damage.", 1, 2, 1, 3),
  Weapon.new("Maul of Destruction", 0, 0, "A massive, two-handed maul capable of crushing anything in its path, leaving only destruction in its wake.", 2, 3, 0, 2),
  Weapon.new("Arcane Wand", 1, 1, "A slender wand carved from rare mystical wood, channeling the raw power of arcane forces.", 1, 1, 3, 2),
  Weapon.new("Shadowblade", 1, 0, "A blade forged from the essence of shadows, allowing its wielder to strike unseen and unheard.", 1, 1, 1, 3),
  Weapon.new("Blazing Axe", 0, 0, "An enchanted axe wreathed in flames, capable of searing through even the toughest armor.", 3, 2, 1, 3),
  Weapon.new("Divine Scepter", 0, 0, "A sacred scepter bestowed upon chosen champions, radiating divine power and smiting evil.", 2, 2, 2, 1),
  Weapon.new("Windsong Bow", 0, 0, "A bow blessed by the spirits of the wind, guiding arrows with the whispers of ancient songs.", 1, 1, 3, 2),
  Weapon.new("Soulreaper Scythe", 3, 2, "A fearsome scythe that harvests souls, feeding on the life force of fallen enemies.", 0, 0, 0, 0),
  Weapon.new("Blunderbuss of Misfires", 0, 0, "A peculiar firearm from a bygone era, known for its comically unpredictable and often disappointing misfires.", 1, 1, 1, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1),
  Weapon.new("Iron sword", 0, 0, "At least it's sharp... a bit?", 1, 1, 0, 1)
  
]

File.open("weapons.txt", "wb") do |file|
  file.write(Marshal.dump(weapons))
end

armors = [
  Armor.new("Iron Plate", 0, 0, "A sturdy iron plate armor.", 25),
  Armor.new("Iron Plate", 0, 0, "A sturdy iron plate armor.", 25),
  Armor.new("Iron Plate", 0, 0, "A sturdy iron plate armor.", 25),
  Armor.new("Leather Tunic", 0, 0, "A light leather tunic for agile movement.", 15),
  Armor.new("Leather Tunic", 0, 0, "A light leather tunic for agile movement.", 15),
  Armor.new("Leather Tunic", 0, 0, "A light leather tunic for agile movement.", 15),
  Armor.new("Magician Robe", 0, 1, "A magical robe that enhances spellcasting.", 10),
  Armor.new("Dragon Scale Mail", 0, 0, "Armor made from the scales of a mighty dragon.", 50),
  Armor.new("Golden Gauntlets", 1, 0, "Enchanted gauntlets that grant incredible strength.", 30)
]

File.open("armors.txt", "wb") do |file|
  file.write(Marshal.dump(armors))
end
=end