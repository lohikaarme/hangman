# frozen_string_literal: true

# Hangman game logic
class Game
  attr_accessor :game
  attr_reader :key_word, :key_length, :guess

  def initialize
    @game = true
    @key_word = ''
    @key_length = 0
    @guess = []
    word_select
    # game_setup
  end

  def word_select
    words = []
    file = File.open('google-10000-english-no-swears.txt', 'r')
    file.readlines.each do |line|
      line = line.chomp
      words << line.downcase if line.length > 4 && line.length < 13
    end
    @key_word = words.sample
    @key_length = @key_word.length
  end

  def player_guess
    guess = ''
    guessing = true
    while guessing
      puts 'Please select a character'
      guess = gets.chomp.downcase
      redo unless guess.match?(/^[a-z]{1}$/)
      guessing = false
    end
    @guess << guess
    p @guess
  end
end
