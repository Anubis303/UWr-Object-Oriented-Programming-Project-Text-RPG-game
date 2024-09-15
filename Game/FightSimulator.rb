(require "./Item")
(require "./Being")
(require "./Character")


=begin
1 - character_1 died
2 - character_2 died
3 - being died
=end

##
# Simulates fights between characters and beings.

class FightSimulator

    ##
    # Simulates a fight between two characters.

    def vs_player(character_1, character_2)
      score_1 = calculate_score_player_strength(character_1)
      score_2 = calculate_score_player_strength(character_2)

      score_1 += character_1.item_weapon.vs_player if character_1.item_weapon && character_1.item_weapon.kind_of?(Weapon)
      score_2 += character_2.item_weapon.vs_player if character_2.item_weapon && character_2.item_weapon.kind_of?(Weapon)
  
      compare_scores_players(character_1, character_2, score_1, score_2)
    end

    ##
    # Simulates a fight between a character and a monster being.
  
    def vs_monster(character, being)
      score_character = calculate_score_player_strength(character)
      score_character += character.item_weapon.vs_monster if character.item_weapon && character.item_weapon.kind_of?(Weapon)

      score_being = being.stat + rand(8)
  
      compare_scores_being(character, being, score_character, score_being, "strength")
    end

    ##
    # Simulates a fight between a character and a ghost being.
  
    def vs_ghost(character, being)
      score_character = calculate_score_player_power(character)
      score_character += character.item_weapon.vs_ghost if character.item_weapon && character.item_weapon.kind_of?(Weapon)

      score_being = being.stat + rand(8)
  
      compare_scores_being(character, being, score_character, score_being, "power")
    end

    ##
    # Simulates a fight between a character and a demon being.
  
    def vs_demon(character, being)
      score_character_strength = calculate_score_player_power(character)
      score_character_power = calculate_score_player_strength(character)
      score_being = being.stat + rand(8)
  
      score_character = [score_character_strength, score_character_power].min 
      score_character += character.item_weapon.vs_demon if character.item_weapon && character.item_weapon.kind_of?(Weapon)

      used = if score_character == score_character_strength
        "strength"
      else
        "force"
      end
  
      compare_scores_being(character, being, score_character, score_being, used)
    end

    ##
    # Calculate score of player in fight with strength.
  
    def calculate_score_player_strength(character)
      score = character.strength + character.b_strength
      score +=  character.item_weapon.strength if character.item_weapon
      score +=  character.item_armor.strength if character.item_armor
      score +=  character.item_1.strength if character.item_1
      score +=  character.item_2.strength if character.item_2

      score += rand(8)
  
      score
    end

    ##
    # Calculate score of player in fight with power.

    def calculate_score_player_power(character)
        score = character.power + character.b_power
        score +=  character.item_weapon.power if character.item_weapon
        score +=  character.item_armor.power if character.item_armor
        score +=  character.item_1.power if character.item_1
        score +=  character.item_2.power if character.item_2
  
        score += rand(8)
    
        score
    end

    ##
    # Gives the result of the fight with being.
  
    def compare_scores_being(character, being, score_character, score_being, used_stat)
        if score_character > score_being
            puts "#{character.name} defeated #{being.name}!"

            if used_stat == "strength"
                character.add_strength_exp(being.stat)
                puts "#{character.name} gained strength-exp!"
            elsif used_stat == "power"
                character.add_power_exp(being.stat)
                puts "#{character.name} gained power-exp!"
            else
                puts "Error"
            end
            return 3
        elsif score_character == score_being
            puts "Hard battle ended with a draw. #{character.name} walks away safely but #{being.name} remains undefeted."
        else
            puts "#{character.name} was defeated by #{being.name}!"
            if_dead = character.take_life(1)

            if if_dead
                return 1
            end 
        end
    end

    ##
    # Gives the result of the fight with being.

    def compare_scores_players(character_1, character_2, score_1, score_2)
        if score_1 < score_2
            puts "#{character_1.name} was defeated by #{character_2.name}!"
            if character_1.item_armor.kind_of?(Armor) && character_1.item_armor.try_to_protect
                puts "However, #{character_1.name} was saved by #{character_1.item_armor.name} and didn't lost HP!"
            else
                if_dead = character_1.take_life(1)
                if if_dead 
                    return 1
                end
            end
        elsif score_1 == score_2
            puts "DRAW!!!"
        else
            puts "#{character_2.name} was defeated by #{character_1.name}!"
            if character_2.item_armor.kind_of?(Armor) && character_2.item_armor.try_to_protect
                puts "However, #{character_2.name} was saved by #{character_2.item_armor.name} and didn't lost HP!"
            else
                if_dead = character_1.take_life(1) 
                if if_dead 
                    return 2
                end
            end
        end
    end
end
