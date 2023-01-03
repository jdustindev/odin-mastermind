# Notes

6 colors for code pegs:
- R: Red
- O: Orange
- Y: Yellow
- G: Green
- B: Blue
- P: Purple

2 colors for key pegs:
- B: Black
- W: White

## Gameplay
Player chooses number of guesses allowed (must be even)

Computer generates code

Game loop begins:

Enter 6 letters (must be from the 6 code peg colors)

press enter

If correct, win! Otherwise, computer gives feedback with key pegs.

Game loop ends.


## Coding
### Game object

instance variables:
- allowed_guesses (int) (will loop this many times?)
- num_guesses: default is 0. How many guesses have been made so far?
- const code_colors: ['R', 'O', 'Y', 'G', 'B', 'P']
- const key_colors: ['B', 'W']
- game_board: [{code, keys}, {code, keys}, ...] - code is an array of 4 pegs, keys is an array of 4 pegs
