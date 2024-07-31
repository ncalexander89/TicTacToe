# frozen_string_literal: true

# game.rb
require_relative 'rules'

require 'pry'

class Game # rubocop:disable Style/Documentation
  include Rules

  attr_accessor :board, :array, :player

  def initialize
    @array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @p1_array = []
    @p2_array = []
    @turn = 1
    puts board
  end

  def board # rubocop:disable Lint/DuplicateMethods
    puts "
    #{@array[0]}  |  #{@array[1]}  |  #{@array[2]}
  -----+-----+-----
    #{@array[3]}  |  #{@array[4]}  |  #{@array[5]}
  -----+-----+-----
    #{@array[6]}  |  #{@array[7]}  |  #{@array[8]}
  "
  end

  def player_selection(sel)
    if @turn.odd?
      @p1_array.push(sel).sort!
    else
      @p2_array.push(sel).sort!
    end
  end

  def player_input(player_number)
    puts "Player #{player_number} select your position"
    loop do
      selection = gets.chomp.to_i
      return selection if @array.include?(selection)

      puts 'Enter a valid number'
    end
  end

  def player_update
    if @turn.odd?
      @array.map! { |number| @selection == number ? 'x' : number }
    else
      @array.map! { |number| @selection == number ? 'o' : number }
    end
  end

  def player_win # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
    WINNING_ARRAY.any? do |win|
      if @turn.odd? && win.all? { |p| @p1_array.include?(p) }
        puts 'Player 1 Wins!'
        return true
      end
      if @turn.even? && win.all? { |p| @p2_array.include?(p) }
        puts 'Player 2 Wins!'
        return true
      end
      false
    end
  end

  def draw
    if @turn == 9
      puts 'Draw Game!'
      return true
    end
    false
  end

  def game
    loop do
      @selection = @turn.odd? ? player_input(1) : player_input(2)
      player_selection(@selection)
      player_update
      board
      return if player_win || draw

      @turn += 1
    end
  end
end
