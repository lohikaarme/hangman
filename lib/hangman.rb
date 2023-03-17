# frozen_string_literal: true

words = []

file = File.open('google-10000-english-no-swears.txt','r')
file.readlines.each do |line|
  line = line.chomp
  words << line.downcase if line.length > 4 && line.length < 13
end

target_word = words.sample
puts target_word