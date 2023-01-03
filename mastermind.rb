class MastermindGame
    CODE_COLORS = ['R', 'O', 'Y', 'G', 'B', 'P']
    KEY_COLORS = ['B', 'W']

    def initialize()
        @allowed_guesses = 10
        @num_guesses = 0
        @game_board = []
    end

    def play()
        while @num_guesses < @allowed_guesses
            play_round
            @num_guesses += 1
        end
    end

    def play_round()
        puts "Enter code: "
        guess = gets.split('')
        puts guess
    end
end

game = MastermindGame.new
game.play