# frozen_string_literal: true

# player.rb
require_relative 'rules'

class Player # rubocop:disable Style/Documentation
  include Rules

  attr_accessor :array, :p1_array, :p2_array, :turn

  def initialize
    @array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @p1_array = []
    @p2_array = []
    @turn = 0
  end

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

  def player1_selection
    puts 'Player 1 select your position'
    @p1sel = gets.chomp.to_i
    until @array.include?(@p1sel) && @p1sel.is_a?(Numeric)
      puts 'Enter a valid number'
      @p1sel = gets.chomp.to_i
    end
    @p1_array.push(@p1sel).sort!
  end

  def player1_update
    @array.map! { |number| @p1sel == number ? 'x' : number }
  end

  def player1_win
    WINNING_ARRAY.any? do |win|
      if win.all? { |p| @p1_array.include?(p) }
        puts 'Player 1 Wins!'
        return true
      end
    end
    @turn += 1
    false
  end

  def draw
    if @turn == 5
      puts 'Draw Game!'
      return true
    end
    false
  end

  def player2_selection
    puts 'Player 2 select your position'
    @p2sel = gets.chomp.to_i
    until @array.include?(@p2sel) && @p2sel.is_a?(Numeric)
      puts 'Enter a valid number'
      @p2sel = gets.chomp.to_i
    end
    @p2_array.push(@p2sel).sort!
  end

  def player2_update
    @array.map! { |number| @p2sel == number ? 'o' : number }
  end

  def player2_win
    WINNING_ARRAY.any? do |win|
      if win.all? { |p| @p2_array.include?(p) }
        puts 'Player 2 Wins!'
        return true
      end
    end
    false
  end
end
