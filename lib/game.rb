# frozen_string_literal: true

# Hangman game logic
class Game
  attr_reader :game, :key_word, :key_length, :word_select

  def initialize
    @game = true
    @key_word = ''
    @key_length = 0
    word_select
    # game_setup
  end

  def self.word_select
    words = []
    file = File.open('google-10000-english-no-swears.txt', 'r')
    file.readlines.each do |line|
      line = line.chomp
      words << line.downcase if line.length > 4 && line.length < 13
    end
    @key_word = words.sample
    @key_length = @key_word.length
  end

  def self.print_test
    puts @key_word
    puts @key_length
  end
end

Game.word_select
Game.print_test
