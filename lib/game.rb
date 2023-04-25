# frozen_string_literal: true

require 'pry'
require_relative 'serial'

# Hangman game logic
class Game
  include BasicSerializable

  attr_accessor :game
  attr_reader :key_word, :key_length, :guess

  def initialize
    @game = true
    @win = false
    @key_word = ''
    @key_letters = []
    @key_length = 0
    @guess = []
    @max_guesses = 10
    word_select
    @turn = 0
    # game_setup
  end

  def run
    load_check
    @turn += 1
    save_check
    # option to load game or start new game
    key_render(@key_letters, @guess)
    player_guess(@guess)
    word_check(@guess, @key_letters)
    # win/loss message
    guess_count(@guess, @max_guesses)
    end_game
    binding.pry
    # p @guess
    # p @key_word
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
    return unless remaining.empty?

    @game = false
    @win = true
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
    puts
    puts viewer.join(' ')
    puts "Guesses: #{guess.join(' ')}"
  end

  def end_game
    return if @game == true

    if @win == true
      puts "Congratulations, you win! The correct word was #{@key_word}"
    else
      puts "The key word was #{@key_word}, better luck next time!"
    end
  end

  def save_check
    choice = ''
    choosing = true
    while choosing
      puts 'Would you like to save your game? (Yes or No)'
      choices = %w[yes no]
      choice = gets.chomp.downcase
      redo unless choices.include?(choice)
      choosing = false
    end
    # binding.pry
    save_game if choice == 'yes'
  end

  def load_check
    return if (@turn != 0)

    choice = ''
    choosing = true
    while choosing
      puts 'Would you like to load your game? (Yes or No)'
      choices = %w[yes no]
      choice = gets.chomp.downcase
      redo unless choices.include?(choice)
      choosing = false
    end
    load_game if choice == 'yes'
  end

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end
    JSON.dump obj
  end

  def save_game
    save_date = serialize
    tmp = File.open('save_file.json', 'w')
    tmp.puts save_date
    tmp.close
  end

  def load_game
    obj = JSON.parse(File.read('save_file.json'))
    obj.each do |key, value|
      instance_variable_set(key, value)
    end
  end
end
