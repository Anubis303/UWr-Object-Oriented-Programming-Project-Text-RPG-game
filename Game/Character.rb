require("./Item")

##
# Represents a player character in the game.

class Character
    attr_reader :type, :strength, :power, :exp_strength, :exp_power, :name
    attr_accessor :gold, :item_weapon, :item_armor, :item_1, :item_2, :b_strength, :b_power, :hp, :base_hp , :exp_power, :exp_strength

    ##
    # Initializes a new character with the specified attributes.
    
    def initialize(type, hp, strength, power)
      @name = nil
      @type = type
      @hp = hp
      @base_hp = hp
      @strength = strength
      @power = power
      @b_strength = 0
      @b_power = 0
      @exp_strength = 0
      @exp_power = 0
      @gold = 1
      @item_weapon = nil
      @item_armor = nil
      @item_1 = nil
      @item_2 = nil
    end

    ##
    # Gives character a name

    def give_name(name)
      @name = name
    end

    ##
    # Reduces the character's health points by the specified amount.
  
    def take_life(x)
      @hp -= x
      puts "#{@name} lost #{x} HP. Remaining HP: #{@hp}."
      if @hp <= 0
        puts "!!! #{@name} DIES !!!"
        return true
      end
    end

    ##
    # Adds experience points to the character's strength attribute. And increase bonus strength if experience is high enough.

    def add_strength_exp(n)
      self.exp_strength += n
  
      if exp_strength >= 10
        self.exp_strength -= 10
        self.b_strength += 1
      end
    end
  
    ##
    # Adds experience points to the character's power attribute. And increase bonus power if experience is high enough.

    def add_power_exp(n)
      self.exp_power += n
  
      if exp_power >= 10
        self.exp_power -= 10
        self.b_power += 1
      end
    end

    ##
    # Displays character's attributes.

    def display
      puts "\n-----------------------"
      puts "Name: #{@name}"
      puts "Race: #{@type}"
      puts "-----------------------"
      puts "Current HP: #{@hp}"
      puts "Current Strength: #{@strength + @b_strength}"
      puts "Current Power: #{@power + @b_power}"
      puts "-----------------------"
      puts "Base HP: #{@base_hp}"
      puts "Base Strength: #{@strength}"
      puts "Base Power: #{@power}"
      puts "-----------------------\n"
    end

    ##
    # Inteface of character's inventory.

    def open_inventory

      def item_to_string(item)
        if item == nil
          "[Empty Slot]"
        else
          item.name
        end
      end

      puts "\n----------------------------------------------"
      puts "Gold: #{@gold}"
      puts "----------------------------------------------"
      puts "1. Main weapon:\t #{item_to_string(@item_weapon)}"
      puts "2. Main armor:\t #{item_to_string(@item_armor)}"
      puts "3. Item 1:\t #{item_to_string(@item_1)}"
      puts "4. Item 2:\t #{item_to_string(@item_2)}"
      puts "----------------------------------------------\n"
      
      options = ["Info about item", "Swap items", "Drop Item", "Close Inventory"]
      puts "\nOptions:"
      options.each_with_index do |element, index|
        puts "#{index + 1}. #{element} "
      end

      choice = gets.chomp
      if choice.downcase == "exit"
        return true
      end
      choice = choice.to_i
      if choice < 1 || choice > options.length
        puts "Wrong input. Try using integers (in right range). Inventory will be closed..."
        return
      elsif choice == 1
        puts "Chose number of item to get info about: "
        item_index = gets.chomp
        if item_index.downcase == "exit"
          return true
        end
        item_index = item_index.to_i
        if item_index < 1 || item_index > 4
          puts "Wrong input. Try using integers (in right range). Inventory will be closed..."
          return
        else
          item_to_display = case
          when item_index == 1 then @item_weapon
          when item_index == 2 then @item_armor
          when item_index == 3 then @item_1
          else @item_2 
          end
          if item_to_display == nil
            puts "[Empty slot]"
          else
            item_to_display.display
          end
        end
      elsif choice == 2
        print "Item A you want to swap: "
        a = gets.chomp
        print "Item B you want to swap: "
        b = gets.chomp
        
        if a.downcase == "exit" || b.downcase == "exit"
          return true
        end
        a = a.to_i
        b = b.to_i

        if a < 1 || a > 4 || a < 1 || a > 4 
          puts "Wrong input. Try using integers (in right range). Inventory will be closed..."
          return
        elsif a == b 
          puts "Can not swap item with itself... inventory will be closed..."
          return
        else
          if a > b 
            a, b = b, a 
          end

          if a == 1 
            if b == 2
              @item_weapon , @item_armor = @item_armor, @item_weapon
              puts "Succesfully swaped #{item_to_string(@item_weapon)} with #{item_to_string(@item_armor)}"
            elsif b == 3
              @item_weapon , @item_1 = @item_1, @item_weapon
              puts "Succesfully swaped #{item_to_string(@item_weapon)} with #{item_to_string(@item_1)}"
            else
              @item_weapon , @item_2 = @item_2, @item_weapon
              puts "Succesfully swaped #{item_to_string(@item_weapon)} with #{item_to_string(@item_2)}"
            end
          elsif a == 2
            if b == 3
              @item_armor , @item_1 = @item_1, @item_armor
              puts "Succesfully swaped #{item_to_string(@item_armor)} with #{item_to_string(@item_1)}"
            else
              @item_armor , @item_2 = @item_2, @item_armor
              puts "Succesfully swaped #{item_to_string(@item_armor)} with #{item_to_string(@item_2)}"
            end
          else
            @item_1 , @item_2 = @item_2, @item_1
            puts "Succesfully swaped #{item_to_string(@item_1)} with #{item_to_string(@item_2)}"
          end
        end

      elsif choice == 3
        puts "Chose number of item to drop: "
        item_index = gets.chomp
        if item_index.downcase == "exit"
          return true
        end
        item_index = item_index.to_i
        if item_index < 1 || item_index > 4
          puts "Wrong input. Try using integers (in right range). Inventory will be closed..."
          return
        elsif item_index == 1
          item_return = @item_weapon
          @item_weapon = nil
          puts "You dropped #{item_to_string(item_return)}"
          return item_return
        elsif item_index == 2
          item_return = @item_armor
          @item_armor = nil
          puts "You dropped #{item_to_string(item_return)}"
          return item_return 
        elsif item_index == 3
          item_return = @item_1
          @item_1 = nil
          puts "You dropped #{item_to_string(item_return)}"
          return item_return
        else 
          item_return = @item_2
          @item_2 = nil
          puts "You dropped #{item_to_string(item_return)}"
          return item_return
        end
      else
        return
      end
    end
  end


# Generating and saving characters
=begin
objects = [
  Character.new("Warrior", 4, 4, 3),
  Character.new("Elf", 4, 3, 4),
  Character.new("Dwarf", 5, 3, 3),
  Character.new("Orc", 5, 6, 0),
  Character.new("Frog", 4, 1, 1)
]

File.open("characters.txt", "wb") do |file|
  file.write(Marshal.dump(objects))
end
=end



