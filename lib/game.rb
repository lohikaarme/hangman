# frozen_string_literal: true

require 'pry'

# Hangman game logic
class Game
  attr_accessor :game
  attr_reader :key_word, :key_length, :guess

  def initialize
    @game = true
    @key_word = ''
    @key_letters = []
    @key_length = 0
    @guess = []
    @max_guesses = 10
    word_select
    # game_setup
  end

  def run
    # option to load game or start new game
    player_guess(@guess)
    word_check(@guess, @key_letters)
    # win condition check
    guess_count(@guess, @max_guesses)
    key_render(@key_letters, @guess)

    p @guess
    p @key_word
  end

  def word_select
    words = []
    file = File.open('google-10000-english-no-swears.txt', 'r')
    file.readlines.each do |line|
      line = line.chomp
      words << line.downcase if line.length > 4 && line.length < 13
    end
    @key_word = words.sample
    @key_letters = key_word.split('')
    @key_length = @key_word.length
  end

  def player_guess(guessed)
    guess = ''
    guessing = true
    while guessing
      puts 'Please select a character'
      guess = gets.chomp.downcase
      redo unless guess.match?(/^[a-z]{1}$/)
      redo if guessed.include?(guess)
      guessing = false
    end
    guessed << guess
  end

  def word_check(guessed, key)
    remaining = (key - guessed)
    if remaining.empty?
      p true
      @game = false
    else
      p remaining.length
    end
  end

  def guess_count(guesses, max_guesses)
    guess_count = guesses.length
    @game = false if guess_count >= max_guesses
    puts "Remaining guesses: #{max_guesses - guess_count}"
  end

  def key_render(key, guess)
    viewer = key.map do |k|
      if guess.include?(k)
        k
      else
        '_'
      end
    end
    p viewer.join
  end
end
