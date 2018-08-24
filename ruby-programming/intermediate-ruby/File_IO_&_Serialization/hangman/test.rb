require "yaml"

class Game_state
  def initialize
    @number_of_guesses = 6
    @secret_word_string = 'gentile'
    @secret_word = @secret_word_string.split('')
    @letter_correct_guesses = Array.new(@secret_word.length, '__')
    @letter_wrong_guesses = []
    @win = false
  end

  def to_s
    "In game_state:\n   #{@number_of_guesses}, #{@secret_word_string}, #{@secret_word}, #{@letter_correct_guesses}, #{@letter_wrong_guesses}, #{@win}\n"
  end

end

game = Game_state.new()
serialized_object = YAML::dump(game)
p serialized_object
object = YAML::load(serialized_object)
# p object(number_of_guesses)
