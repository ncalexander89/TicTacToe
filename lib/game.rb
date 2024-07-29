# frozen_string_literal: true

# game.rb
require_relative 'player'

class Game < Player # rubocop:disable Style/Documentation
  def game # rubocop:disable Metrics/MethodLength
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
