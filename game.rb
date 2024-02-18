require_relative 'board'
require_relative 'player'

class Game
  def initialize
    # welcome messages
    puts 'Welcome to Tic Tac Toe!'
    puts 'Player 1 will be X, player 2 will be O'
    puts

    # instructions
    puts 'When asked to input row and column, and for example, you want it in the cell in the center (direction row 2 and column 2), you should type: 2, press enter, then 2, press enter.'
    puts

    # player creation
    puts 'Please, enter player 1 name:'
    @player1 = Player.new(gets.chomp, 'X')
    puts

    puts 'Please, enter player 2 name:'
    @player2 = Player.new(gets.chomp, 'O')
    puts

    # create board
    @board = Board.new
    @board.display

    # reset variables
    reset
  end

  # set some game variables
  def reset 
    @game_over = false
    @moves = 0
    @current_player = @player2
  end

  # game loop
  def play
    until @game_over
      puts
      # switch between players
      @current_player = if @current_player == @player2
                          @player1
                        else
                          @player2
                        end

      # prompt player for their move
      puts "It's #{@current_player.name}'s turn."
      puts 'Please choose row and column:'
      enter_parameters
      validate_coord

      # make move with the given parameters
      make_move(@current_player, @row, @col)
      puts

      # display board
      @board.display

      # check to see if game over
      winner = check_winner
      draw = check_draw

      # increment moves
      @moves += 1
    end

    # congratulate winner if there is one, else tie
    if winner
      puts "Congratulations #{@current_player.name}! You've won the match!"
    else
      puts 'You two tied!'
    end

    puts
    # initializes game again
    initialize
  end

  # prompts player for row and column input
  def enter_parameters
    @row = validate_param(gets.chomp.to_i - 1)
    @col = validate_param(gets.chomp.to_i - 1)
  end

  # asks player to input again if the parameter isn't valid
  def validate_param(param)
    while param < 0 || param > 2
      puts 'Please enter a valid parameter. It must be between 1 and 3.'
      param = gets.chomp.to_i - 1
    end
    param
  end

  # asks player to input again if coordinate isn't empty
  def validate_coord
    until @board.cell_empty?(@row, @col)
      puts 'The cell is already occupied, please choose again.'
      enter_parameters
    end
  end

  # make a move given player, row and col
  def make_move(player, row, col)
    @board[row, col] = player.symbol
  end

  # define winning combos
  WINNING_COMBINATIONS = [
    [[0, 0], [0, 1], [0, 2]], # top row
    [[1, 0], [1, 1], [1, 2]], # mid row
    [[2, 0], [2, 1], [2, 2]], # bottom row
    [[0, 0], [1, 0], [2, 0]], # left col
    [[0, 1], [1, 1], [2, 1]], # mid col
    [[0, 2], [1, 2], [2, 2]], # right col
    [[0, 0], [1, 1], [2, 2]], # diagonal top-left
    [[0, 2], [1, 1], [2, 0]]  # diagonal top-right
  ].freeze

  # check if there is winner
  def check_winner
    # compares winning combos with current board
    WINNING_COMBINATIONS.each do |combination|
      rows, cols = combination.transpose
      symbols = rows.map.with_index { |row, index| @board[row, cols[index]] }
      if symbols.uniq.length == 1 && symbols.first != ' '
        @game_over = true
        return true
      end
    end
    false
  end
  
  @max_moves = 9

  # checks if draw
  def check_draw
    return true if @moves == @max_moves
  
    false
  end
end