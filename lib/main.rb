# frozen_string_literal: true

# main.rb
require_relative 'game'

include Rules # rubocop:disable Style/MixinUsage

Game.new.game
