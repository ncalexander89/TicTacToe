# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/rules'

describe Game do
  let(:game) { Game.new }
  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
  end
  describe 'game win' do
    context 'When board shows 3 in a row and is player 1 turn' do
      it 'Displays Player 1 as the winner and ends the game' do
        game.p1_array = [1, 2, 3] # Set a winning combination for Player 1
        expect(game).to receive(:puts).with('Player 1 Wins!')
        # game.board(game.p1_array)  # Show the board with winning numbers
        expect(game.player_win).to be true
      end
    end
  end
end
