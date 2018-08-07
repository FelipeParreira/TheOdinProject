class Game

  attr_reader :isFinished, :round

  def initialize
    @isFinished = false
    @turn = 0
    @round = 1
    @table = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @players = [ { name: '', hasWon: false, symbol: 'X', points: 0 },
  			         { name: '', hasWon: false, symbol: 'O', points: 0 } ]
    puts "We are starting a new tic-tac-toe game!"
    puts "Enter the name of the first player (first to play - X): "
    @players[0][:name] = gets.chomp
    puts "Enter the name of the second player (last to play - O): "
    @players[1][:name] = gets.chomp
    puts "Our game has two players: #{@players[0][:name]} and #{@players[1][:name]}."
    puts "#{@players[0][:name]} is going to start the game."
  end

  def showWinner
    if @players[@turn][:hasWon]
      @players[@turn][:points] += 1
      puts "#{@players[@turn][:name]} won the round!"
      puts "#{@players[1 - @turn][:name]} lost the round!"
    end
  end

  def showTable
    puts "     0    1    2 "
    puts "  ================="
    for i in 0..2
      print "#{i} "
      print "||"
      for j in 0..2
        print @table[i][j] ? " #{@table[i][j]} ": "   "
        print "||"
      end
      puts ""
      puts "  ================="
    end
  end

  def playTurn
    puts "It's #{@players[@turn][:name]}'s turn!"
    move = []
    cont = true
    while cont
      puts "Please, type the line and the column numbers to insert your move."
      puts "(e.g. if you want to move to the bottom-left corner, type '20'): "
      move = gets.chomp.split('').map { |x| x.to_i }
      move = [4, 4] if move[0] == nil

      if move.all? { |x| x <= 2 && x >= 0}
        if @table[move[0]][move[1]] == nil
          cont = false
        else
          puts "This spot is already occupied. Choose another one."
        end
      else
        puts "Invalid input."
      end
    end

    @table[move[0]][move[1]] = @players[@turn][:symbol]
    if checkIfWon
      @players[@turn][:hasWon] = checkIfWon
      showWinner
      puts "The round is over."
      @isFinished = true
    elsif checkTie
      puts "It was tie."
      puts "The round is over."
      @isFinished = true
    end
    if @isFinished
      nextRound
    else
      @turn = 1 - @turn
    end
  end

  def checkIfWon
    if @table[0].all? { |x| x == @players[@turn][:symbol] } ||
       @table[1].all? { |x| x == @players[@turn][:symbol] } ||
       @table[2].all? { |x| x == @players[@turn][:symbol] }
      return true
    else
      for i in 0..2
        if @table[0][i] == @table[1][i] &&
           @table[0][i] == @table[2][i] &&
           @table[0][i] == @players[@turn][:symbol]
          return true
        end
      end
      if (@table[0][0] == @table[1][1] &&
         @table[0][0] == @table[2][2] &&
         @table[0][0] == @players[@turn][:symbol]) ||
         (@table[0][2] == @table[1][1] &&
          @table[1][1] == @table[2][0] &&
          @table[1][1] == @players[@turn][:symbol])
        return true
      end
    end
    return false
  end

  def checkTie
    if @table[0].all? { |x| x != nil } &&
       @table[1].all? { |x| x != nil } &&
       @table[2].all? { |x| x != nil }
      return true
    else
      return false
    end
  end

  def reset
    for i in 0..1
      @players[i][:hasWon] = false
    end
    for i in 0..2
      for j in 0..2
        @table[i][j] = nil
      end
    end
    @isFinished = false
    @turn = 0
  end

  def nextRound
    reset
    @round += 1
  end

  def restartGame
    puts "The round has been restarted (new round)."
    reset
    puts "This is round number #{@round}."
  end

  def showScores
    puts "Scores"
    puts "=========================="
    for i in 0..1
      puts "#{@players[i][:name]}: #{@players[i][:points]} points"
    end
    puts "=========================="
  end

  private :reset, :checkTie, :checkIfWon, :showWinner
end

game = Game.new()
continue = true


while continue
  puts "This is round number #{game.round}."
  game.showTable
  game.playTurn
  puts "Menu:"
  puts "0. restart round"
  puts "1. quit game"
  puts "2. show scores"
  puts "3. next round"
  puts "Any other key to continue."
  answer = gets.chomp

  case answer
  when "0"
    game.restartGame
  when "1"
    continue = false
    game.showScores
    puts "Exiting game..."
  when "2"
    game.showScores
  when "3"
    game.nextRound
  else
  end
end
