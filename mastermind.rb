class MastermindGame
    CODE_COLORS = ['R', 'O', 'Y', 'G', 'B', 'P']
    KEY_COLORS = ['B', 'W']

    def initialize(player)  # player should be 'h' for human or 'c' for computer
        @player = player.upcase
        @allowed_guesses = 10
        @num_guesses = 0
        @game_board = []
        @code = []
        generate_code
    end

    def play()
        if (@player != 'H' && @player != 'C')
            puts "Invalid player choice. Choose H or C."
            exit
        end
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
        if (@player == 'H')
            guess = gets.chop.upcase.chars
            guess_valid = check_guess(guess)
            if guess_valid
                keys = give_feedback(guess)
                turn = {guess: guess, key_pegs: keys}
                @game_board.push(turn)
            end
        elsif (@player == 'C')
            turn = computer_guess
            @game_board.push(turn)
        end
        display_board
    end

    def generate_code()
        if (@player == 'H')
            4.times do
                @code << CODE_COLORS[rand(6)]
            end
        elsif (@player == 'C')
            valid = false
            while (valid == false)
                puts "Enter your code"
                code = gets.chomp.split('')
                valid = check_guess(code)
            end
            @code = code
        end
    end

    def check_guess(guess)
        guess_valid = guess.all? { |item| CODE_COLORS.include?(item) }
        if (guess.length != 4)
            guess_valid = false
        end
        if guess_valid == false
            puts "Invalid code. Try again."
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

    def computer_guess
        code_guess = []
        if (@game_board.empty?)
            code_guess = ['R', 'R', 'R', 'R']
        else
            4.times do
                code_guess << CODE_COLORS[rand(6)]
            end
        end
        keys = give_feedback(code_guess)
        {guess: code_guess, key_pegs: keys}
    end
end

puts "Enter 'h'(uman) to guess or 'c'(omputer) to create a code and have the computer guess:"
player = gets.chomp
p player
game = MastermindGame.new(player)
game.play