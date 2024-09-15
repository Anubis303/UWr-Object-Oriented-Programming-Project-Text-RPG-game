require("./Item")
require("./Being")
require("./Character")
require("./Activities")
require("./Field")
require("./Map")


##
# This class is a main, which uses other classes to execute the game.


class Game

    ##
    # Initializes a new game

    def initialize
      @character_1 = nil
      @character_2 = nil
      @field_1_i = nil
      @field_2_i = nil
      @name_1 = nil
      @name_2 = nil
      @map = nil
    end

    ##
    # Opens menu of the Game
    def start
      puts "\nHi! Welome to the \"Eyes of the World\" a simple Text RPG game!"
  
      loop do
        puts "\n     MENU:"
        puts "--------------"
        puts "1. Start Game"
        puts "2. Rules & Lore"
        puts "3. Exit"
        puts "--------------"
  
        choice = gets.chomp.to_i
  
        case choice
        when 1
          start_game
        when 2
          display_rules
        when 3
          puts "Thanks for starting the game and goodbye!"
          break
        else
          puts "Invalid choice. Please try again."
        end
      end
    end

    ##
    # Displays rules and lore of the game.

    def display_rules
      lore = <<~TEXT
      ====================================      LORE    ===============================================
      After many years, noble battles, great inventions, the blossoming of civilization, 
      the world is... about to end? 
      You don't know exactly what does it mean. To be honest, you are almost sure that nobody 
      does. However, every sorcerer, witch, mag, fortuneteller, future teller, magic goat and 
      tea grounds agree: THE END IS NEAR. You find that message plausible, the world you live 
      in looks like a shadow of it pasts self. Only old artifacts, ruins, forgotten technology 
      and stories remain after the glory of the old days. You live in the so-called 
      Eye of the World - the area around the big lake. One of a few viable places. 
      The terrains further f
      rom the lakes are too dry for any alive being. Moreover, every decade, 
      every year, every month, every day, every hour the lake becomes smaller, smaller and smaller.  
      However, there is hope! Not for all the peasants around but for YOU - a strong traveler. 
      A few weeks ago, a crow with a message arrived to yours Eye of the World. Some powerful 
      wizard makes Noah's Ark for best humans, elves and dwarfs.
      He can only take one person from this area with him. Finally, you have a good reason to find 
      and kill that one annoying traveler that destroys your reputation and claims to be 
      better than you...
      =================================================================================================
      TEXT

      rules = <<~TEXT
      ____________BASIC INFORMATION___________
      This is a text RPG game designed for 2 
      players. Everything takes place in terminal 
      and in your ★imagination★. It's the 
      turn-based game so you and your oponent 
      make moves for turns.

      ____________GOAL OF THE GAME____________
      Goal of the game is to kill other player
      or to survive longer than him.

      __________________TURN__________________
      1. Beginning
      You can open your inventory or check your 
      stats.
      2. Move
      In your turn, you have to travel to the
      field next to the previous one you were
      standing on. The board is a circle.
      (If you want to know why, your welcome to
      read the lore above). Fields are either Lands,
      where new monsters and tresures apper or
      Inhabitated Areas, where you make some 
      activities. If you come across other player
      you are welcome to attack.

     __________________CONTROLS________________
     Use integers to make choices or words written
     in square brackets - [Example].  You can end
     game by writing \"Exit\" anytime (besides
     chosing name - name Exit is too cool to be 
     removed).

      ________________CHARACTER_______________
      Thera are few possible classes of 
      characters. Your character, called in game
      a traveler, is leveluping. Killing an 
      enemies gives you points. Every 10 od them
      transfer into additional strength or power
      (depends on type of enemy you killed).
      Every traveler can have 4 items. Obviously
      your character don't have 10 hands so only
      one weapon can be used at the time as well
      as one armor. Make sure it's in right slot.
      (Sword hidden in your backpack won't help you)

      _________________REST____________________
      Almost everything is described, so you 
      surely figure everything out... or the 
      fantasy world will be more mysterious.
      Netherless, I belive in you ✰
      Good luck and have fun!
      TEXT
      
      print "\n\n"
      print lore
      print "\n"
      print rules
      print "\n[Exit with Enter]"
      gets
    end

    ##
    # Starts game
  
    def start_game
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

      def chosing_characters

        playable_characters = nil
        File.open("characters.txt", "rb") do |file|
          playable_characters = Marshal.load(file.read)
        end
        
        # Character select player 1
        puts "PLAYER 1\n"
        print "Write a name of your character: "
        @name_1 = gets.chomp
        if @name_1.length > 20
          puts "Quite a long name... Hope you remember it"
        end
        puts "From now on you are #{@name_1}. Now it's time to select a character class: "
        playable_characters.each_with_index do |element, index|
          next if index == playable_characters.length - 1

          puts "#{index + 1}. #{element.type}: \tStrength #{element.strength}, \tPower #{element.power}, \tHP #{element.hp}"
        end

        choice = gets.chomp
        if choice.downcase == "exit"
          return true
        end
        choice = choice.to_i
        if choice < 1 || choice >= playable_characters.length
          puts "EASTER EGG character for invalid input in character selection: Frog"
          @character_1 = playable_characters[playable_characters.length - 1].dup
        else
          @character_1 = playable_characters[choice - 1].dup
        end
        @character_1.give_name(@name_1)

        # Character select player 2
        puts "\n\n\n\n\nPLAYER 2\n"
        print "Write a name of your character: "
        @name_2 = gets.chomp
        if @name_2.length > 20
          puts "Quite a long name... Hope you remember it"
        end
        puts "From now on you are #{@name_2}. Now it's time to select a character class: "
        playable_characters.each_with_index do |element, index|
          next if index == playable_characters.length - 1

          puts "#{index + 1}. #{element.type}: \tStrength #{element.strength}, \tPower #{element.power}, \tHP #{element.hp}"
        end

        choice = gets.chomp
        if choice.downcase == "exit"
          return true
        end
        choice = choice.to_i
        if choice < 1 || choice >= playable_characters.length
          puts "EASTER EGG character for invalid input in character selection: Frog"
          @character_2 = playable_characters[playable_characters.length - 1].dup
        else
          @character_2 = playable_characters[choice - 1].dup
        end
        @character_2.give_name(@name_2)
      end

      
      @map = Map.new
      if_exit = chosing_characters
      if if_exit == true
        return
      end

      @field_1_i = 0
      @field_2_i = @map.fields.length/2

      @map.fields[@field_1_i].characters << @character_1
      @map.fields[@field_2_i].characters << @character_2
        
      player_turn = 1 # 1 - player 1, 2 - player 2

      # Main loop
      while true
        name = if player_turn == 1
          @name_1
        else
          @name_2
        end

        character = if player_turn == 1
          @character_1
        else
          @character_2
        end

        field = if player_turn == 1
          @field_1_i
        else
          @field_2_i
        end 

        options_before_move = ["Make a move", "Open inventory", "Show my stats"]

        puts "\n\n\n\n\n\n\nTurn of #{name}!"
        puts "\nYou are currently in the #{@map.fields[field].name}. #{@map.fields[field].description}"
        
        # Loop for actions before move
        while true 
          puts "\nOptions:"
          options_before_move.each_with_index do |option, index|
            puts "#{index+1}. #{option}"
          end

          # Player's choice 
          choice = gets.chomp
          if choice.downcase == "exit"
            return
          end
          choice = choice.to_i
          if choice < 1 || choice > options_before_move.length
            puts "Invalid input. Write an integer (in right range)"

          # Make move
          elsif choice == 1
            neighbors = @map.neighbors(field)
            puts "\nYou can go to:"
            puts "1. #{neighbors[0]}"
            puts "2. #{neighbors[1]}"
            where = gets.chomp
            if where.downcase == "exit"
              return
            end

            where = where.to_i
            if where < 1 || where > 2
              puts "\nInvalid input. Write an integer (in right range)"
            else
              @map.fields[field].characters.delete(character)
              where = if where == 1
                field += 1
              else
                field -= 1
              end
              if player_turn == 1
                @field_1_i  = where
              else
                @field_2_i = where
              end
              answer = @map.fields[field].interface(character, @map)
              
              if answer == true
                return
              elsif answer == 1
                puts "\n\n\n\nTHE END OF THE GAME"
                puts "#{@name_2} wins!"
                return
              elsif answer == 2
                puts "\n\n\n\nTHE END OF THE GAME"
                puts "#{@name_1} wins!"
                return
              end
              break
            end

          # Open inventory
          elsif choice == 2
            answer = character.open_inventory
            if answer != nil && answer.kind_of?(Item)
              field.items << answer
            elsif answer == true
              return
            end

          # Show my stats
          else
            character.display
          end
        end
        player_turn = if player_turn == 1
          2
        else
          1
        end
      end
    end
  
end

game = Game.new

game.start