# frozen_string_literal: true

# Set winning array as constant
module Rules
  include Rules
  WINNING_ARRAY = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  # Define Player class with updatable arrays
  class Player
    attr_accessor :array, :p1_array, :p2_array, :turn

    def initialize
      @array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @p1_array = []
      @p2_array = []
      @turn = 0
    end

    # Displays board
    private

    def board
      puts "

    #{@array[0]}  |  #{@array[1]}  |  #{@array[2]}
  -----+-----+-----
    #{@array[3]}  |  #{@array[4]}  |  #{@array[5]}
  -----+-----+-----
    #{@array[6]}  |  #{@array[7]}  |  #{@array[8]}

  "
    end

    # Player 1 makes selection, selection is stored in array
    def player1_selection
      puts 'Player 1 select your position'
      @p1sel = gets.chomp.to_i
      until @array.include?(@p1sel) && (@p1sel.is_a? Numeric)
        puts 'Enter valid number'
        @p1sel = gets.chomp.to_i
      end
      @p1_array = @p1_array.push(@p1sel).sort
    end

    # Board array is updated with player 1 selection
    def player1_update
      @array = @array.map do |number|
        @p1sel == number ? 'x' : number
      end
    end

    # Check if player 1 plays winning move, or if draw
    def player1_win
      WINNING_ARRAY.each do |win|
        if win.all? { |p| @p1_array.include?(p) }
          puts 'Player 1 Wins!'
          return true
        end
      end
      @turn += 1
    end

    def draw
      return unless @turn == 5

      puts 'Draw Game!'
      true
    end

    # Player 2 makes selection, selection is stored in array
    def player2_selection
      puts 'Player 2 select your position'
      @p2sel = gets.chomp.to_i
      until @array.include?(@p2sel) && (@p2sel.is_a? Numeric)
        puts 'Enter valid number'
        @p2sel = gets.chomp.to_i
      end
      @p2_array = @p2_array.push(@p2sel).sort
    end

    # Board array is updated with player 2 selection
    def player2_update
      @array = @array.map do |number|
        @p2sel == number ? 'o' : number
      end
    end

    # Check if player 2 plays winning move
    def player2_win
      WINNING_ARRAY.each do |win|
        if win.all? { |p| @p2_array.include?(p) }
          puts 'Player 2 Wins!'
          return true
        end
      end
    end
  end

  # game class inherits player variables and loops until win or draw
  class Game < Player
    def game
      board
      loop do
        player1_selection
        player1_update
        board
        return if player1_win || draw

        player2_selection
        player2_update
        board
        return if player2_win
      end
    end
  end
end

Game.new.game
