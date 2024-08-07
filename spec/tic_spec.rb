# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/rules'

describe Game do # rubocop:disable Metrics/BlockLength
  let(:game) { Game.new }
  before do
    allow(game).to receive(:puts) # Avoid actual printing to console
  end
  describe 'Player Win' do
    context 'When winning array includes players array' do
      it 'Displays player 1 as the winner and ends the game' do
        expect(game.turn).to be_odd
        game.p1_array = [1, 2, 3] # Set a winning combination for Player 1
        expect(game).to receive(:puts).with('Player 1 Wins!')
        expect(game.player_win).to be true
      end
      it 'Displays player 2 as the winner and ends the game' do
        game.p2_array = [4, 5, 6] # Set a winning combination for Player 2
        game.turn = 2
        expect(game.turn).to be_even
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
    context 'When player makes a selection' do
      it 'It pushes player 1 selection to their array and sorts it' do
        game.turn = 1
        expect(game.turn).to be_odd
        game.player_selection(2)
        game.player_selection(1)
        game.player_selection(5)
        game.player_selection(7)
        expect(game.p1_array).to eq([1, 2, 5, 7])
      end
      it 'It pushes player 2 selection to their array and sorts it' do
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
  describe 'Player Input' do # rubocop:disable Metrics/BlockLength
    context 'When its players turn' do
      it 'Returns player 1s input if it is available in array' do
        allow(game).to receive(:gets).and_return('5')
        expect(game).to receive(:puts).with('Player 1 select your position')
        input_selection = game.player_input(1)
        expect(input_selection).to eq(5)
      end
      it 'Puts Enter a Valid number if player 1 input not available in array' do
        allow(game).to receive(:gets).and_return('abc', '4') # Simulate invalid and then valid input
        expect(game).to receive(:puts).with('Player 1 select your position')
        expect(game).to receive(:puts).with('Enter a valid number')
        input_selection = game.player_input(1) # Run the player_input method
        expect(input_selection).to eq(4) # Expect the valid selection to be returned
      end

      it 'Returns player 2s input if it is available in array' do
        allow(game).to receive(:gets).and_return('4')
        selection = game.player_input(2)
        expect(game.array.include?(selection))
      end
      it 'Puts Enter a Valid number if player 2 input not available in array' do
        allow(game).to receive(:gets).and_return('c', '2') # Simulate invalid and then valid input
        expect(game).to receive(:puts).with('Enter a valid number')
        selection = game.player_input(2) # Run the player_input method
        expect(selection).to eq(2) # Expect the valid selection to be returned
      end
    end
  end
  describe 'Player Update' do
    context('When players selection is valid') do
      it('Marks Player 1 selection as x') do
        expect(game.turn).to be_odd
        game.instance_variable_set(:@selection, 5) # Simulate Player 1 selecting position 5
        game.player_update
        expect(game.array).to eq([1, 2, 3, 4, 'x', 6, 7, 8, 9])
      end
      it('Marks Player 2 selection as o') do
        game.turn = 2
        expect(game.turn).to be_even
        game.instance_variable_set(:@selection, 4) # Simulate Player 2 selecting position 4
        game.player_update
        expect(game.array).to eq([1, 2, 3, 'o', 5, 6, 7, 8, 9])
      end
    end
  end
end
