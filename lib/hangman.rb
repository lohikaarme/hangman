# frozen_string_literal: true

require 'pry'

require_relative 'game'

def game_start
  game = Game.new
  game.player_guess
  binding.pry
  # game.playhile game.game
end

game_start
