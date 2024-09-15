##
# Represents a being in the game.

class Being
    attr_reader :name, :description, :type, :stat

    ##
    # Initializes a new being with the specified name, type, and description.
  
    def initialize(name, description, type, stat)
      @name = name
      @description = description
      @type = type
      @stat = stat
    end

    ##
    # Displays being's attributes.

    def display
      puts "In this area lives #{name}."
      puts "#{description}"
      puts "This #{type} will stay here until defeated."
      if type == "monster"
        puts "Strength: #{stat}"
      elsif type == "ghost"
        puts "Power: #{stat}"
      else 
        puts "Your wicker stat: #{stat}"
      end
    end
  end

# Generating and saving beings
=begin
objects = [
  Being.new("Grimlok", "A ferocious monster with gnarled fangs and glowing red eyes.", "monster", 3),
  Being.new("Spectral Whisperer", "A ghostly apparition that haunts the halls, whispering chilling secrets.", "ghost", 2),
  Being.new("Azazel", "A powerful demon wreathed in flames, with a sinister grin.", "demon", 8),
  Being.new("Nyx the Cursed", "A tormented soul trapped between realms, seeking vengeance for a long-forgotten betrayal.", "ghost", 3),
  Being.new("Gorgon", "A fearsome monster with venomous snakes for hair, turning all who meet its gaze into stone.", "monster", 5),
  Being.new("Moloch", "A demon lord of immense power, whose thirst for chaos knows no bounds.", "demon", 7),
  Being.new("Banshee", "A mournful spirit whose wailing cries foretell impending doom.", "ghost", 5),
  Being.new("Harbinger of Shadows", "A mysterious entity that lurks in the darkness, feasting on fear and despair.", "ghost", 4),
  Being.new("Chimera", "A monstrous creature with the body of a lion, the head of a goat, and the tail of a serpent.", "monster", 3),
  Being.new("Lilith", "A seductive demoness who ensnares unsuspecting souls with her irresistible charm.", "demon", 5),
  Being.new("Poltergeist", "A mischievous ghost that delights in causing havoc and moving objects with unseen force.", "ghost", 2),
  Being.new("The Leviathan", "An ancient sea serpent of colossal size, capable of sinking entire fleets with a single breath.", "monster", 10),
  Being.new("Belial", "A cunning and manipulative demon who tempts mortals into embracing their darkest desires.", "demon", 4),
  Being.new("Wraith", "A vengeful spirit bound to the mortal realm, seeking retribution for its untimely demise.", "ghost", 4),
  Being.new("Minotaur", "A monstrous half-man, half-bull creature, lurking deep within the labyrinth, waiting to strike.", "monster", 3),
  Being.new("Lamia", "A seductive serpent-like creature that preys upon the desires of unsuspecting mortals.", "monster", 2),
  Being.new("Incubus", "A malevolent demon who visits sleeping mortals, tormenting them with dark nightmares.", "demon", 2),
  Being.new("Siren", "A beautiful yet deadly creature whose enchanting voice lures sailors to their watery graves.", "monster", 4),
  Being.new("Shade", "A shadowy spirit that dwells in the realm between light and darkness, feeding on human fear.", "ghost", 3),
  Being.new("Cerberus", "A three-headed hound guarding the gates of the underworld, preventing escape for the damned.", "monster", 7),
  Being.new("Mephistopheles", "A cunning demon known for striking Faustian bargains, claiming souls for eternal damnation.", "demon", 10),
  Being.new("Phantom", "An ethereal specter that materializes in the dead of night, haunting the dreams of the living.", "ghost", 1),
  Being.new("Kraken", "A colossal sea monster with massive tentacles capable of dragging entire ships to the depths.", "monster", 10),
  Being.new("Hecate", "A powerful goddess of magic and sorcery, shrouded in darkness and mystery.", "demon", 6),
  Being.new("Wendigo", "A cannibalistic creature that roams the wintry forests, driven by insatiable hunger.", "monster", 5),
  Being.new("Pazuzu", "A malevolent demon who spreads plague and disease, bringing suffering to all in its wake.", "demon", 5),
  Being.new("Revenant", "A vengeful undead spirit, risen from the grave to seek revenge on those who wronged it in life.", "ghost", 4),
  Being.new("Cyclops", "A massive one-eyed giant, wielding immense strength and wielding a massive club.", "monster", 6),
  Being.new("Succubus", "A seductive demoness who seduces mortals in their dreams, draining their life force.", "demon", 3),
  Being.new("Phantom Executioner", "A spectral figure that stalks the night, delivering justice to those who have evaded the law.", "ghost", 7),
  Being.new("Tentacled Tinkerer", "A twisted inventor with mechanical tentacles, creating bizarre contraptions fueled by steam and dark ambition.", "monster", 6),
  Being.new("Darth Malice", "A powerful Lord wielding a staff adorned with a crimson crystal, consumed by the dark side of magic.", "demon", 8),
  Being.new("Automaton Sentinel", "An animated suit of armor adorned with intricate engravings and powered by a mysterious, pulsating energy.", "monster", 8),
  Being.new("Eldritch Abomination", "A nightmarish creature from the depths of the cosmos, its form twisting and shifting in ways that defy mortal comprehension.", "monster", 12)]

File.open("beings.txt", "wb") do |file|
  file.write(Marshal.dump(objects))
end
=end


