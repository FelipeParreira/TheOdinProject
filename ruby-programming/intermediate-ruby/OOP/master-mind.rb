class Game

  attr_reader :black_key_pegs, :answer, :guesses, :points_guesser, :points_coder

  def initialize
    conts = true
    while conts
      puts "Who is the code-breaker? (You: y; the PC: c)"
      @answer = gets.chomp.downcase
      if @answer == 'y' || @answer == 'c'
        conts = false
      else
        puts "Invalid input"
      end
    end

    @points_guesser = 0
    @points_coder = 0
    @black_key_pegs = 0
    @white_key_pegs = 0
    @exact_matches = []
    @matches = []
    @guess = []
    @guesses = 12
    @code = []

    if @answer == 'y'
      for i in 0..3
        @code[i] = rand(6)
      end
      # @code = [1, 2, 3, 4] // just for testing purposes
    end
  end

  def pcGuess
    if @guess.empty?
      for i in 0..3
        @guess[i] = rand(6)
      end
    else
      newGuess = [-1, -1, -1, -1]

      for el in @exact_matches
        newGuess[el] = @guess[el]
      end

      neg_indexes = newGuess.each_index.select { |index| newGuess[index] == -1}

      for el in @matches
        cont = true
        while cont
          ind = rand(neg_indexes.length)
          chosen_index = neg_indexes[ind]
          if chosen_index != el
            cont = false
            neg_indexes.slice!(ind)
            newGuess[chosen_index] = @guess[el]
          end
        end
      end

      if newGuess.each_index.any? { |index| newGuess[index] == -1}
        neg_ind = newGuess.each_index.select { |index| newGuess[index] == -1}
        for el in neg_ind
          conti = true
          while conti
            number = rand(6)
            if (@rem - @matches).all? { |index| @guess[index]!= number } &&
              !(@tried_values_per_position[el].include?(number))
              conti = false
              newGuess[el] = number
            end
          end
        end
      end

      @guess = newGuess
    end
  end

  def initComp
    puts "0 -- green"
    puts "1 -- blue"
    puts "2 -- red"
    puts "3 -- purple"
    puts "4 -- yellow"
    puts "5 -- blank"

    @tried_values_per_position = Hash.new([])

    cont = true
    while cont
      puts "Enter your secret code: "
      puts "(e.g. green-red-blue-purple would be '0123'): "
      @code = gets.chomp.split('').map { |x| x.to_i }


      unless @code.all? { |x| x <= 5 && x >= 0} && @code.length == 4
        puts "Invalid input."
      else
        cont = false
      end
    end

  end


  def playTurnComp

    if @code.empty?
      initComp
    end

    pcGuess

    puts "This is the PC guess: "
    p @guess

    checkGuess
    displayPegs

    if @black_key_pegs == 4
      puts "The PC guessed it right."
    else
      puts "Wrong guess. PC is going to try again."
      @guesses -= 1
      puts "The PC still has #{@guesses} remaining guesses."
    end
  end

  def playTurnPerson
    puts "0 -- green"
    puts "1 -- blue"
    puts "2 -- red"
    puts "3 -- purple"
    puts "4 -- yellow"
    puts "5 -- blank"


    cont = true
    while cont
      puts "Please, guess the 4-color code."
      puts "(e.g. green-red-blue-purple would be '0123'): "
      @guess = gets.chomp.split('').map { |x| x.to_i }
      @guess = [6, 6] if @guess[0] == nil

      unless @guess.all? { |x| x <= 5 && x >= 0} && @guess.length == 4
        puts "Invalid input."
      else
        cont = false
      end
    end
    # p @guess
    checkGuess
    displayPegs

    if @black_key_pegs == 4
      puts "You guessed it right."
    else
      puts "Wrong guess. Try again."
      @guesses -= 1
      puts "You still have #{@guesses} remaining guesses."
    end
  end

  def checkGuess
    @black_key_pegs = 0
    @white_key_pegs = 0
    @exact_matches = []
    @matches = []
    @match_values = []
    @rem = []
    temp = @code

    for i in 0..3
      if @guess[i] == @code[i]
        @black_key_pegs += 1
        @exact_matches.push(i)
      else
        @rem.push(i)
        @tried_values_per_position[i].push(@guess[i]) if !(@tried_values_per_position[i].include?(@guess[i]))
      end
    end



    for el in @rem
      if temp.include?(@guess[el])
        if !(@exact_matches.include?(temp.index(@guess[el])))
          if !(@match_values.include?(@guess[el]))
            @matches.push(el)
            @white_key_pegs += 1
            @match_values.push(@guess[el])
          end
        end
      end
    end

    puts "Exact matches are:  #{@exact_matches.map do |x|
    @guess[x]
    end }"
    puts "Other matches are:  #{@matches.map do |x|
    @guess[x]
    end}"

    @points_guesser += @black_key_pegs + 0.5 * @white_key_pegs
    @points_coder += 1 if @black_key_pegs < 4
  end

  def displayPegs
    puts "Black pegs: #{@black_key_pegs}"
    puts "White pegs: #{@white_key_pegs}"
  end

end


game = Game.new()

continue = true

while continue
  game.answer == 'y' ? game.playTurnPerson : game.playTurnComp
  continue = false if game.black_key_pegs == 4 || game.guesses == 0
end

person_points = game.answer == 'y' ? game.points_guesser :  game.points_coder
pc_points = game.answer == 'c' ? game.points_guesser :  game.points_coder

if game.black_key_pegs == 4
  puts "The code was found."
else
  puts "Code still unkown."
end

puts "The PC scored: #{pc_points}"
puts "You scored: #{person_points}"
