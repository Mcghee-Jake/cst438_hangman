class GamesController < ApplicationController
    # start a new game
    def start 
        @game = Game.create( {:word => get_random_word, :remaining_guesses => 6, :letters_revealed => ''})
        @message = 'Enter a letter or hint'
    end 

    # guess a letter 
    def play
        begin 
            @game = Game.find(params[:id])
            guess = params[:guess]
            if guess.blank?
                @message = 'Enter a letter or a hint'
            elsif guess == 'hint' 
                @game.hint
                @message = "you have #{@game.remaining_guesses} guesses left."
            elsif guess.length > 1
                @message = "Enter only a single letter or the word hint"
            elsif @game.guess?(guess)
                @message = "Yes there is a #{guess} in the word."
            else  
                @message = "There is no #{guess} in the word."
            end 
            if @game.won?
                @message = "You win!"
                @game.destroy()
            elsif  @game.remaining_guesses <= 0 
                @message = "You lost.  The word was "+@game.word
                @game.destroy
            end
        rescue ActiveRecord::RecordNotFound   
            # no game exists, start a new game
            @game = Game.create( {:word => get_random_word, :remaining_guesses => 6, :letters_revealed => ''})
            @message = 'Enter a letter or hint'
            return
        end
    end

    private 
    
    def get_random_word
        words = Word.all
        result = words[rand(words.length)].word
        puts "WORD DEBUG", result
        return result
    end
end

