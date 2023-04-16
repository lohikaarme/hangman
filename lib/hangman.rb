# frozen_string_literal: true

require 'pry'

require_relative 'game'

def game_start
  # new game or load game
  # binding.pry
  # game.playhile game.game
end

def new_game
  game = Game.new
  game.run while game.game
end

def load_game
  # load json
end

def play_again
  # get prompt
end

new_game
# game_start
