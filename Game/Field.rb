(require "./Map")
(require "./Activities")
(require "./Item")
(require "./Character")
(require "./FightSimulator")

##
# Represents a field or location in the game world.

class Field
    attr_reader :name, :description
    attr_accessor :characters, :items, :beings
  
    ##
    # Initializes a new field with the specified name and description.

    def initialize(name, description)
      @name = name
      @description = description
      @characters = []
      @items = []
      @beings = []
      @fightsimulator = FightSimulator.new
    end

    ##
    # Displays information about the characters and beings on the field, allowing the player to interact with them.

    def interface(character)
      puts "You are in #{@name}."
      puts @description
      puts ""
  
      # Display characters
      if @characters.any?
        puts "Characters on this field:"
        @characters.each_with_index do |character, index|
          puts "#{index + 1}. #{character.name} (HP: #{character.hp}, Strength: #{character.strength + character.b_strength}, Power: #{character.power + character.b_power})"
        end
      end
      puts ""
  
      # Player's choice to attack characters
      if @characters.any?
        puts "Select a character to attack or [Pass]:"
        choice = gets.chomp 
        if choice.downcase == "exit"
          return true
        elsif choice.downcase == "pass"
          puts "You didn't attack anyone."
        else
          choice = choice.to_i 
          if choice.between?(1, @characters.length)
            character_2 = @characters[choice - 1]
            puts "You attacked #{character_2.name}!"
            result = @fightsimulator.vs_player(character, character_2)
            if result == 1 || result == 2
              return result
            end
          else
            puts "Invalid input. Skipping attack."
          end
        end
      end

      @characters << character

      # Display beings
      if @beings.any?
        puts "Beings on this field:\n"
        @beings.each_with_index do |being, index|
          puts "--------------------#{index+1}--------------------"
          being.display
          puts""
        end
        puts ""
        puts "Beings attack you !!!" 
        beings_left = []
        @beings.each do |being|
          puts "\n#{being.name} attacks !!!"
          puts  "[Enter]"
          input = gets.chomp
          if input.downcase == "exit"
            return true
          end
          result = case
          when being.type == "monster" then @fightsimulator.vs_monster(character, being)
          when being.type == "ghost" then @fightsimulator.vs_ghost(character, being)
          when being.type == "demon" then @fightsimulator.vs_demon(character, being)
          end

          if result == 1
            return 1
          elsif result != 3
            beings_left << being
          end
          @beings == beings_left
        end
      end


      # Display items
      if @items.any?
        puts "You can take some items from here. Chose a number to take an item or write [Inventory] to open your inventory or [End] to stop taking items"
        while true
          puts "\n\nItems on this field:"
          @items.each_with_index do |item, index|
            puts "#{index + 1}. #{item.name}"
          end
          puts ""
            
          choice = gets.chomp
          if choice.downcase == "exit"
            return true
          elsif choice.downcase == "inventory"
            answer = character.open_inventory
            if answer == true
              return true
            elsif answer != nil && answer.kind_of?(Item)
              @items << answer
            end
          elsif choice.downcase == "end"
            break
          else
          choice = choice.to_i
          if choice < 1 || choice > items.length
            puts "Invalid input."
          else
              if character.item_weapon == nil
                character.item_weapon = @items[choice-1]
                @items.delete_at(choice-1)
                puts "Taken succesfully!"
              elsif character.item_armor == nil
                character.item_armor = @items[choice-1]
                @items.delete_at(choice-1)
                puts "Taken succesfully!"
              elsif character.item_1 == nil
                character.item_1 = @items[choice-1]
                @items.delete_at(choice-1)
                puts "Taken succesfully!"
              elsif character.item_2 == nil
                character.item_2 = @items[choice-1]
                @items.delete_at(choice-1)
                puts "Taken succesfully!"
              else
                puts "Can not take - full inventory."
              end
            end
          end
        end
      end
    end 
  end
  
##
# Specialised class. Represents a land field in the game world.

class Land < Field
  attr_reader :type, :cards_to_draw

  ##
  # Inherits method from the Field class and additionaly adds amount of cards to draw (beings, gold, items that spawn there)

  def initialize(name, description, cards_to_draw)
    super(name, description)
    @cards_to_draw = cards_to_draw
  end

  ##
  # Inherits method from the Field class and additionaly let's new cards spawn.

  def interface(character, map)
    cards_now = @items.length + @beings.length
    while cards_now < cards_to_draw
      new_card = map.draw_card
      if new_card.kind_of?(Item)
        @items << new_card
      elsif new_card.kind_of?(Being)
        @beings << new_card
      else 
        puts "While entering the #{@name}, you found a gold bellows containing #{new_card} gold piece!"
        character.gold += 1
      end
      cards_now += 1
    end
    super(character)
  end
end

##
# Represents an inhabited area field in the game world.

class InhabitedArea < Field
    attr_accessor :activities

    ##
    # Represents an inhabited area field in the game world.

    def initialize(name, description, activities)
      super(name, description)
      @activities = activities
    end

    ##
    # Inherits method from the Field class and additionaly displays the available activities in the area, allowing the player to use them.
  
    def interface(character, map)
  
      super(character)
      puts "\nNow you can safly ake advantage of the wealth of the #{@name}"

      # Display activities
      puts "Available activities:"
      @activities.each_with_index do |activity, index|
        puts "#{index + 1}. #{activity.name} -- #{activity.description}"
      end
      puts ""
  
      # Player's choice to use an activity
      if @activities.any?
        while true
          puts "Select an activity to use or [End] to end using activities:"
          choice = gets.chomp 
          if choice.downcase == "exit"
            return true
          elsif choice.downcase == "end"
            break
          end
          choice = choice.to_i
          if choice.between?(1, @activities.length)
            activity = @activities[choice - 1]

            # Player's choice Medic
            if activity.kind_of?(Medic)
              puts "\nThis medic will heal you up to #{activity.up_to} HP if you pay for each #{activity.price_per_hp}"
              print "HP you want to restore: "
              choice = gets.chomp 
              if choice.downcase == "exit"
                return true
              end
              choice = choice.to_i
              activity.heal(character, choice)

            # Player's choice Shop
            elsif activity.kind_of?(Shop)
              puts "\nItems and prices in that shop: "
              activity.goods_prices.each_with_index do |element, index|
                puts "#{index + 1}. #{element[0].name}\t Price: #{element[1]}"
              end
              puts "\nWrite a number of iteam you are interested in or write [Cancel]"
              choice = gets.chomp
              if choice.downcase == "exit"
                return true
              elsif choice.downcase != "cancel"
                choice = choice.to_i
                if choice < 1 || choice > activity.goods_prices.length
                  puts "Invalid item number." 
                else
                  activity.goods_prices[choice-1][0].display
                  puts "Do you want to buy tis item [Yes] [No]"
                  yes_no = gets.chomp 
                  if yes_no.downcase == "exit"
                    return true
                  elsif yes_no.downcase == "yes"
                    activity.buy(choice, character)
                  elsif yes_no.downcase != "no"
                    puts "Invalid input."
                  end
                end
              end

            # Player's choice Alchemist
            elsif activity.kind_of?(Alchemist)
              puts "This alchemist will melt any of your items into #{activity.gold_per_item}"
              answer = activity.melting(character)
              if answer == true
                return true
              end

            # Player's choice Witch
            else
              puts "\nThis witch will use her magic for free, but it's dangerous... Are you willing to continue? [Yes] [No]"
              choice = gets.chomp
              if choice.downcase == "exit"
                return true
              elsif choice.downcase == "no"
                puts "You walk out. Nothing happens."
              elsif choice.downcase == "yes"
                answer = activity.magic(character)
                if answer == 1
                  return 1
                end
              elsif choice.downcase == "avada kedavra"
                puts "You cast a powerful spell, however #{activity.name} deflects it!!!"
                puts "!!! #{character.name} DIES !!!"
                return 1
              else 
                puts "Invalid input. Nothing happens."
              end
            end
            puts "\nYou used the service of #{activity.name} activity!"
            
          else
            puts "Invalid input. No activity used."
          end
        end
      else
        puts "No activities available in this area."
      end
    end
  end


# Generating and saving fields
=begin
lands = [
  Land.new("Deep Forest", "A dense forest with towering ancient trees.", 1),
  Land.new("Plains of Serenity", "Vast open plains with gentle breezes.", 1),
  Land.new("Rocky Peaks", "Majestic mountains with rugged rocky peaks.", 1),
  Land.new("Abandoned Cemetery", "A haunting cemetery with weathered tombstones.", 1),
  Land.new("Ruins of a Forgotten City", "Crumbling ruins of a once magnificent city.", 2),
  Land.new("Misty Marshlands", "A mist-covered marshland teeming with mysterious creatures.", 1),
  Land.new("Enchanted Grove", "A magical grove filled with mystical flora and fauna.", 1),
  Land.new("Desolate Wasteland", "A barren wasteland devoid of life and hope.", 1),
  Land.new("Whispering Winds", "A land where the wind whispers ancient secrets.", 1),
  Land.new("Eerie Graveyard", "An eerie graveyard shrouded in darkness and mystery.", 1),
  Land.new("Sunlit Meadows", "Gentle meadows basked in warm sunlight.", 1),
  Land.new("Cursed Swamp", "A cursed swamp that brings misfortune to those who enter.", 1),
  Land.new("Snowy Tundra", "A frozen tundra covered in a blanket of pristine white snow.", 1),
  Land.new("Mystic Caverns", "Enigmatic caverns filled with magical crystals.", 1),
  Land.new("Forgotten Temple", "An ancient temple lost in time and forgotten by civilization.", 1),
  Land.new("Stormy Coastline", "A treacherous coastline battered by powerful ocean storms.", 1),
  Land.new("Forbidden Forest", "A forbidden forest teeming with mythical creatures.", 1),
  Land.new("Blazing Volcano", "A fiery volcano spewing molten lava into the air.", 1),
  Land.new("Whimsical Wonderland", "A whimsical land filled with enchantment and wonder.", 1),
  Land.new("Rustic Scrapyard", "A desolate scrapyard littered with broken remnants of ancient contraptions.", 1)]


medic1 = Medic.new("Healer's Touch - Medic", "A gentle healer offering their divine touch to mend wounds.", 1, 2)
medic2 = Medic.new("Medic: Elixir of Vitality", "A mystical elixir said to rejuvenate the body and restore vitality.", 2, 4)

armor1 = Armor.new("Leather Armor", 0, 0, "Flexible and lightweight armor made from supple leather", 25)
armor2 = Armor.new("Chainmail Armor", 0, 0, "Interlocking metal rings woven into a protective chainmail suit", 30)

weapon1 = Weapon.new("Steel Axe", 0, 0, "A sturdy axe forged from fine steel", 2, 1, 0, 1)
weapon2 = Weapon.new("Steel Sword", 0, 0, "A reliable sword crafted from quality steel", 1, 2, 0, 1)

jewelry1 = Item.new("Amulet of Power", 0, 1, "A mystical amulet that enhances the wearer's magical abilities")

shop1_goods = [[armor1, 3], [weapon1, 2], [jewelry1, 2]]
shop2_goods = [[armor2, 4], [weapon2, 2]]

shop1 = Shop.new("The Adventurer's Shop", "A quaint shop offering essential gear for daring adventurers.", shop1_goods)
shop2 = Shop.new("Shop: Rusty Relics", "A dusty shop filled with worn but reliable weapons and armor.", shop2_goods)

alchemist1 = Alchemist.new("Mystic Alchemy", "A mystical alchemist offering arcane services and transformations.", 2)
alchemist2 = Alchemist.new("The Gilded Alchemist", "A renowned alchemist specializing in transmutation and rare materials.", 3)


inhabitatedareas = [
  InhabitedArea.new("Village", "A small village bustling with activity", [medic1, alchemist1]),
  InhabitedArea.new("Town", "A lively town with various establishments",[medic2]),
  InhabitedArea.new("City", "A bustling city filled with people from all walks of life",[shop1, alchemist2]),
  InhabitedArea.new("Camp", "A temporary campsite of nomadic travelers",[shop2])
]

fields =  inhabitatedareas + lands
begin
 File.open("fields.txt", "wb") do |file|
   file.write(Marshal.dump(fields))
 end
end
=end

