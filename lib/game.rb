# frozen_string_literal: true

# game.rb
require_relative 'player'

class Game # rubocop:disable Style/Documentation
  def initialize
    @player = Player.new
  end

  def game # rubocop:disable Metrics/MethodLength
    @player.board
    loop do
      @player.player1_selection
      @player.player1_update
      @player.board
      return if @player.player1_win || @player.draw

      @player.player2_selection
      @player.player2_update
      @player.board
      return if @player.player2_win
    end
  end
end
