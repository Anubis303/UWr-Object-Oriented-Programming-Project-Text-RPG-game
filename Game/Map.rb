require("./Item")
require("./Being")
require("./Character")
require("./Activities")
require("./Field")
require("./Map")

##
# Represents the game map.

class Map
    attr_accessor :fields, :cards

    ##
    # Initializes a new map by reading Fields, Beings and Items from files.
  
    def initialize
      @fields = []
      @cards = []

      beings = nil
      File.open("beings.txt", "rb") do |file|
        beings = Marshal.load(file.read)
      end

      weapons = nil
      File.open("weapons.txt", "rb") do |file|
        weapons = Marshal.load(file.read)
      end

      armors = nil
      File.open("armors.txt", "rb") do |file|
        armors = Marshal.load(file.read)
      end

      gold = Array.new(6, 1) + Array.new(3, 2)
      
      @cards = beings + weapons + armors
      @cards = @cards.shuffle

      effect1 = lambda do |character|
        character.b_strength += 3
        puts "You feel a surge of power flowing through you. Your base strength has increased by 1!"
      end
      
      effect2 = lambda do |character|
        character.b_power += 2
        puts "You are enveloped in a mystical aura. Your power has increased by 2!"
      end
      
      negative_effect1 = lambda do |character|
        character.b_power = 0
        puts "A curse befalls you, weakening your power. You lose your additional power!!!"
      end
      
      negative_effect2 = lambda do |character|
        character.gold = 0
        puts "Hmmm... Nothing happened? But wait where is she and where is your gold?!"
      end
      
      
      witch1 = Witch.new("Mysterious Enchantress", "A mysterious witch who possesses ancient arcane powers.", effect1, negative_effect2)
      witch2 = Witch.new("The Cackling Hag", "A cackling hag with a penchant for mischief and dark magic.", effect1, negative_effect2)
      
      fields = nil
      File.open("fields.txt", "rb") do |file|
        fields = Marshal.load(file.read)
      end

      @fields = fields

      fields[1].activities << witch1
      fields[2].activities << witch2
      fields.shuffle
    end

    ##
    # Draws a card from the map's collection of cards, removing it from the collection.

    def draw_card
      return nil if @cards.empty?
      @cards.shift
    end

    ##
    # Return names of adjacent fields.
  
    def neighbors(n)
      [@fields[(n+1) % @fields.length].name, @fields[(n-1) % @fields.length].name]
    end
  end
  