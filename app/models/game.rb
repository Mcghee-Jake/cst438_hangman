class Game < ApplicationRecord
    
    # return string showing letters guessed correctly
    # and underscore for letters still to be guessed
    def display 
        disp = ''
        self.word().each_char { |c| 
           if self.letters_revealed().include?(c) 
              disp.concat(c)
              disp.concat(' ')
           else
              disp.concat('_ ')
           end
        }
        disp
    end
    
    # has user won the game?
    def won?()
        self.word().each_char { |c|
            if !self.letters_revealed().include?(c)
              return false
            end
        }
        true
    end
      
    # is user letter in the word?
    #   g is one character entered by user
    def guess?(g) 
        if self.word().include?(g)
           self.update({:letters_revealed => self.letters_revealed().concat(g)})
           return true
        else
           self.update({:remaining_guesses => self.remaining_guesses() - 1})
           return false
        end
    end
      
    # user asked for a hint
    def hint 
        self.update({:remaining_guesses => self.remaining_guesses() - 1})
        self.word().each_char { |c| 
           if !self.letters_revealed().include?(c)
              self.update({:letters_revealed => self.letters_revealed().concat(c)})
              break
           end
        }
    end
end

