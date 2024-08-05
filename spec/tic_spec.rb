# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/rules'

describe Game do # rubocop:disable Metrics/BlockLength
  let(:game) { Game.new }
  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
  end
  describe 'Game Win' do
    context 'When board shows 3 in a row and is player 1 turn' do
      it 'Displays player 1 as the winner and ends the game' do
        game.p1_array = [1, 2, 3] # Set a winning combination for Player 1
        expect(game).to receive(:puts).with('Player 1 Wins!')
        expect(game.player_win).to be true
      end
    end
    context 'When board shows 3 in a row and is player 2 turn' do
      it 'Displays player 2 as the winner and ends the game' do
        game.p2_array = [4, 5, 6] # Set a winning combination for Player 2
        game.turn = 2
        expect(game).to receive(:puts).with('Player 2 Wins!')
        expect(game.player_win).to be true
      end
    end
  end
  describe 'Draw Game' do
    context 'When there are no more options to select' do
      it 'Displays draw game and ends game' do
        game.turn = 9
        expect(game).to receive(:puts).with('Draw Game!')
        expect(game.draw).to be true
      end
    end
  end
  describe 'Player Selection' do
    context 'When player 1 makes a selection' do
      it 'It pushes players selection to their array and sorts it' do
        game.turn = 1
        expect(game.turn).to be_odd
        game.player_selection(2)
        game.player_selection(1)
        game.player_selection(5)
        game.player_selection(7)
        expect(game.p1_array).to eq([1, 2, 5, 7])
      end
    end
    context 'When player 2 makes a selection' do
      it 'It pushes players selection to their array and sorts it' do
        game.turn = 2
        expect(game.turn).to be_even
        game.player_selection(9)
        game.player_selection(7)
        game.player_selection(5)
        game.player_selection(2)
        expect(game.p2_array).to eq([2, 5, 7, 9])
      end
    end
  end
end
