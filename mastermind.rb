class MastermindGame
    CODE_COLORS = ['R', 'O', 'Y', 'G', 'B', 'P']
    KEY_COLORS = ['B', 'W']

    def initialize()
        @allowed_guesses = 10
        @num_guesses = 0
        @game_board = []
        @code = []
        generate_code
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

    def generate_code()
        4.times do
            @code << CODE_COLORS[rand(6)]
        end
    end
end

game = MastermindGame.new
game.play