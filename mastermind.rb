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
            if win?
                puts "You got the code! It was #{@code.join}"
                exit
            end
            @num_guesses += 1
        end
        puts "You ran out of guesses!"
    end

    def play_round()
        guess_valid = false
        puts "\nEnter code: "
        guess = gets.chop.upcase.chars
        guess_valid = check_guess(guess)
        if guess_valid
            keys = give_feedback(guess)
            turn = {guess: guess, key_pegs: keys}
            @game_board.push(turn)
        end
        display_board
    end

    def generate_code()
        4.times do
            @code << CODE_COLORS[rand(6)]
        end
    end

    def check_guess(guess)
        guess_valid = guess.all? { |item| CODE_COLORS.include?(item) }
        if (guess.length != 4)
            guess_valid = false
        end
        if guess_valid == false
            puts "Invalid guess. Try again."
            play_round
        end
        guess_valid
    end

    def give_feedback(guess)
        system("clear")|| system("cls")
        puts @code  # remove this when we are sure it works
        key_pegs = []
        code_colors = count_colors(@code)
        # Only add a B or W peg if the instances of a code color are not used up
        # (This prevents adding a white peg when there is already a peg for a color)
        # (That is, without this extra logic, it would add a white peg for every guess of a color even if it is only matched once)
        guess.each_with_index do |item, index|
            if (@code.include?(item) && code_colors[item] > 0)
                item == @code[index] ? key_pegs << "B" : key_pegs << "W"
                code_colors[item] -= 1
            end
        end
        key_pegs.sort
    end

    def count_colors(colors)
        colors.reduce(Hash.new(0)) do |totals, color|
            totals[color] += 1
            totals
        end
    end

    def display_board
        @game_board.each do |row|
            puts "#{row[:guess].join} | #{row[:key_pegs].join}"
        end
    end

    def win?
        @game_board[-1][:key_pegs] == ['B', 'B', 'B', 'B']
    end
end

game = MastermindGame.new
game.play