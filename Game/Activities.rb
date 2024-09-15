##
# This represents the Witch by her name, description and method of casting spells.

class Witch
    attr_reader :name, :description, :effect_1, :effect_2

    ##
    # Initializes a new witch with the given name, description, and effects.
  
    def initialize(name, description, effect_1, effect_2)
      @name = name
      @description = description
      @effect_1 = effect_1
      @effect_2 = effect_2
    end

    ##
    # Applies random effect to character.
  
    def magic(character)
      options = [
        ->(character) { character.take_life(1) ; puts "Dark energy surrounds you, draining your life force. You lose 1 HP!" },
        ->(character) { character.hp += 1 ; puts "You feel a surge of power flowing through you. Your HP has increased by 1!"},
        ->(character) { character.b_strength = 0 ; puts "A curse befalls you, weakening your strength. You lose your additional strength!!!"},
        ->(character) { character.b_power = 0 ; puts "A curse befalls you, weakening your strength. You lose your additional strength!!!"},
        ->(character) { character.b_strength += 2; character.b_power += 2 ; puts "You feel a surge of power flowing through you. Your Strength and Power has increased by 2!!!" },
        @effect_1,
        @effect_2
      ]
      chosen_option = options.sample
      return chosen_option.call(character)
    end
  end

  ##
  # This represents the Medic by his name, description and method of healing.

  class Medic
  attr_reader :name, :description, :price_per_hp, :up_to

  ##
  # Initializes a new witch with the given name, description, price per restored HP and maximum healing. .

  def initialize(name, description, price_per_hp, up_to)
    @name = name
    @description = description
    @price_per_hp = price_per_hp
    @up_to = up_to
  end

  ##
  # Heals the character by the specified amount.

  def heal(character, amount)
    if amount > @up_to
      puts "Invalid amount. Can only heal up to #{@up_to} HP."
      return
    end

    cost = @price_per_hp * amount
    if character.gold < cost
      puts "Insufficient gold. Cannot afford healing."
      return
    end

    if character.base_hp - character.hp > amount
      puts "Invalid amount. You have lost only #{character.base_hp - character.hp} HP."
    end

    character.gold -= cost
    character.hp += amount
    puts "#{character.name} has been healed by #{amount} HP."
  end
end

##
# This represents the Shop by his name, description and method of buying.

class Shop
    attr_reader :name, :description, :goods_prices

    ##
    # Initializes a new shop with the given name, description, and goods prices.
  
    def initialize(name, description, goods_prices)
      @name = name
      @description = description
      @goods_prices = goods_prices
    end

    ##
    # Allows the character to buy the nth item from the shop.
  
    def buy(n, character)
      if n < 1 || n > @goods_prices.length
        puts "Invalid item number."
        return
      end
  
      item, price = @goods_prices[n - 1]
      if price > character.gold
        puts "Insufficient gold. Cannot buy the item."
        return
      end
  
      if character.item_weapon.nil?
        character.item_weapon = item
      elsif character.item_armor.nil?
        character.item_armor = item
      elsif character.item_1.nil?
        character.item_1 = item
      elsif character.item_2.nil?
        character.item_2 = item
      else
        puts "Inventory is full. Cannot buy the item."
        return
      end
  
      character.gold -= price
      puts "#{character.name} bought #{item.name} for #{price} gold."
    end
  end
  
##
# This represents the Alchemist by his name, description and method of melting.

class Alchemist
  attr_reader :name, :description, :gold_per_item

  ##
  # Initializes a new alchemist with the given name, description, and gold per item.

  def initialize(name, description, gold_per_item)
    @name = name
    @description = description
    @gold_per_item = gold_per_item
  end

  ##
  # Lets the player choose an item to melt and gain gold in return.

  def melting(character)
    items = [character.item_weapon, character.item_armor, character.item_1, character.item_2]
    
    puts "Choose an item to melt into gold or \"Cancel\":"
    items.each_with_index do |item, index|
      if item.nil?
        puts "#{index + 1}. [Empty slot]"
      else
        puts "#{index + 1}. #{item.name}"
      end
    end

    print "Position of the item: "
    choice = gets.chomp 
    if choice.downcase == "exit"
      return true
    elsif choice.downcase == "cancel"
      return
    end
    choice = choice.to_i
    if choice < 1 || choice > items.length
      puts "Invalid choice."
      return
    end

    item = items[choice - 1]
    if item.nil?
      puts "No item to melt."
      return
    end

    character.gold += @gold_per_item
    if choice == 1
      character.item_weapon = nil
    elsif choice == 2
      character.item_armor = nil
    elsif choice == 3
      character.item_1 = nil
    else
      character.item_2 = nil
    end
    puts "#{item.name} has been melted. You gained #{@gold_per_item} gold."
  end
end

