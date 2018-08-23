# function that draws the stick figure according to the number of remaining_guesses
def show_graphics(remaining_guesses)
  case remaining_guesses
  when 6
    puts """
        ||======|
        ||      |
        ||
        ||
        ||
    ____||____
    """
  when 5
    puts """
        ||======|
        ||      |
        ||      0
        ||
        ||
    ____||____
    """
  when 4
    puts """
        ||======|
        ||      |
        ||      0
        ||      |
        ||
    ____||____
    """
  when 3
    puts """
        ||======|
        ||      |
        ||      0
        ||     /|
        ||
    ____||____
    """
  when 2
    puts """
        ||======|
        ||      |
        ||      0
        ||     /|\\
        ||
    ____||____
    """
  when 1
    puts """
        ||======|
        ||      |
        ||      0
        ||     /|\\
        ||     / \\
    ____||____
    """
    # the game ends after the man is completely drawn and hanged
    # (not showed here, but it occurs when there are no more remaining guesses)
  end
end

# file number to be opened at the beginning of game if desired
$number = 0

# function that saves the state of the game and asks the user if he wants to exit the game
def save_game_state(numberOfGuesses, secretWord, secretWordString, letterCorrectGuesses, letterWrongGuesses, win)
  puts "Do you want to save your current file state? [y/N]"
  answer_open = gets.chomp
  if answer_open != "" && answer_open.downcase[0] != "n"
    puts "What pre-name do you want to give to your file?"
    puts "(press enter to save to the file opened at the beginning of the game)"
    pre_name = gets.chomp

    if pre_name === ""
      name = Dir.glob("game_states/*_game_state.txt")[$number]
    else
      name = "game_states/#{pre_name}_game_state.txt"
    end

    File.write(name,
      """    number_of_guesses = #{numberOfGuesses}
    secret_word_string = \"#{secretWordString}\"
    secret_word = #{secretWord}
    letter_correct_guesses = #{letterCorrectGuesses}
    letter_wrong_guesses = #{letterWrongGuesses}
    win = #{win}""")
    File.write("last_saved.txt", name)
    puts "Your game state is saved in #{name}"
  end

  puts "Do you want to exit the game? [y/N]"
  answer_exit = gets.chomp
  ex = answer_exit != "" && answer_exit.downcase[0] != "n"
  puts "Exiting game..." if ex
  return ex
end

# basic initialization of variables
number_of_guesses = 0
secret_word = ''
secret_word_string = secret_word
secret_word = secret_word.split('')
letter_correct_guesses = Array.new(secret_word.length, '__')
letter_wrong_guesses = []
win = false

puts "Do you want to open a previous game state? [y/N]"
answer_open = gets.chomp

if answer_open != "" && answer_open.downcase[0] != "n"
  game_state_files = Dir.glob("game_states/*_game_state.txt")
  game_state_files.each_with_index { |file, index| puts "#{index + 1}. #{file}"}

  loop do
    puts "Choose the file (type the correspondent number):"
    puts "(or press enter to open the last saved file)"
    $number = gets
    if $number === "\n"
      fil = File.open("last_saved.txt", "r")
      fil.rewind
      $number = game_state_files.index(fil.gets.strip)
      break
    end

    $number = $number.chomp[0].to_i
    if $number > 0 && $number <= game_state_files.length
      $number -= 1 # arrays are zero indexed, but the user needs not know this
      break
    else
      puts "Wrong input. Try Again."
    end
  end

  game_file = File.open(game_state_files[$number.to_i], "r")
  num_lines = game_file.readlines.size
  game_file.rewind
  num_lines.times {eval(game_file.gets.strip)} # evaluates the lines in the .txt file, assigning the saved values to the variables
  game_file.close
  puts "Your previous state has been recovered."
else
  # open the dictionary file
  f = File.open("5desk.txt", "r")

  # count the number of lines of the file
  number_of_lines = f.readlines.size

  # choose random word (each word is in a line between 5 and 12 characters long)
  len = 0
  while len < 5 || len > 12
    f.rewind
    chosen_line_number = rand(number_of_lines)
    chosen_line_number.times{ f.gets }
    secret_word = f.gets.strip # select line from file and removes whitespace
    len = secret_word.length
  end

  # close file
  f.close

  # total number of guesses when the game starts
  number_of_guesses = 6

  secret_word_string = secret_word
  secret_word = secret_word.split('')
  letter_correct_guesses = Array.new(secret_word.length, '__')
  letter_wrong_guesses = []
  win = false
end

# tracks if the user wants to exit the game
ex_state = false

loop do
  show_graphics(number_of_guesses)
  puts "The secret word is as follows: "
  puts letter_correct_guesses.join(' ')
  puts "Number of remaining_guesses: #{number_of_guesses}"
  puts "Your past wrong guesses: #{letter_wrong_guesses.join(' ')}"
  ex_state = save_game_state(number_of_guesses, secret_word, secret_word_string, letter_correct_guesses, letter_wrong_guesses, win)
  break if ex_state # exits if the user so wants

  puts "Do you want to guess the whole word already? [y/N]"
  answer = gets.chomp
  if answer != "" && answer.downcase[0] != "n"
    puts "Guess the word: "
    answer_word = gets.chomp
    if answer_word.downcase === secret_word_string.downcase
      puts "You got it!"
      win = true
    else
      puts "Fail."
      number_of_guesses = 0
    end
    # if the user wants to guess the whole word, he has only one attempt; after that, he either loses or wins the game
    break
  end

  puts "Guess a letter: "
  answer_letter = gets.chomp.downcase

  if letter_correct_guesses.include?(answer_letter) || letter_correct_guesses.include?(answer_letter.upcase)
    puts "You have already entered this letter."
    next
  elsif letter_wrong_guesses.include?(answer_letter) || letter_wrong_guesses.include?(answer_letter.upcase)
    puts "You have already entered this letter. And it is wrong."
    # we do not penalize the user if he enters the same wrong letter more than once
    next
  elsif !(secret_word.include?(answer_letter)) && !(secret_word.include?(answer_letter.upcase))
    puts "Wrong guess!"
    number_of_guesses -= 1
    letter_wrong_guesses.push(answer_letter) # records which wrong letters have been entered
    break if number_of_guesses === 0
    next
  end

  puts "Your letter guess is right!"
  # loop through the secret word and fill the places in the array to complete the guessed word
  while secret_word.index(answer_letter) || secret_word.index(answer_letter.upcase)
    ind_down = secret_word.index(answer_letter)
    ind_up = secret_word.index(answer_letter.upcase)

    if ind_down
       letter_correct_guesses[ind_down] = secret_word[ind_down]
       secret_word[ind_down] = "__"
    end

    if ind_up
      letter_correct_guesses[ind_up] = secret_word[ind_up]
      secret_word[ind_up] = "__"
    end

  end

  # break the loop if the word has been totally guessed
  if !(letter_correct_guesses.include?('__'))
    win = true
    break
  end

  # break if there are no remaining guesses
  break if number_of_guesses === 0
end

if win
  puts "You won!"
elsif number_of_guesses === 0 # to avoid the game over message when the user just exited the game
  puts "You lost!"
  puts "The secret word was '#{secret_word_string}'."
end
