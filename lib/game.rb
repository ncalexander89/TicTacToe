# frozen_string_literal: true

# game.rb
require_relative 'rules'

require 'pry'

class Game # rubocop:disable Style/Documentation
  include Rules

  attr_accessor :array, :p1_array, :turn, :p2_array

  def initialize
    @p1_array = []
    @p2_array = []
    @turn = 1
    @array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def board
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

  def player_win # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    WINNING_ARRAY.any? do |win|
      if @turn.odd? && win.all? { |win_array| @p1_array.include?(win_array) }
        puts 'Player 1 Wins!'
        true
      elsif @turn.even? && win.all? { |win_array| @p2_array.include?(win_array) }
        puts 'Player 2 Wins!'
        true
      else
        false
      end
    end
  end

  def draw
    if @turn == 9
      puts 'Draw Game!'
      true
    else
      false
    end
  end

  def game
    board
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
