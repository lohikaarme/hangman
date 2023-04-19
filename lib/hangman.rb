# frozen_string_literal: true

require 'pry'

require_relative 'game'
require_relative 'serial'

class Main

  attr_accessor :game_obj

  def game_start
    # new game or load game
    # binding.pry
    # game.playhile game.game
  end
  
  def new_game
    game_obj = Game.new
    game_obj.run while game_obj.game
    # binding.pry
  end

  def load_game
    # load json
  end

  def play_again
    # get prompt
  end
end

Main.new.new_game

# game_start
