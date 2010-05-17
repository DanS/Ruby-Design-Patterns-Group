class Game
  attr_accessor :player1, :player2
  def initialize(game_type, player1 = "player1", player2 = "player2")
    @player1 = player1 
    @player2 = player2
    @game = game_type.new(player1, player2)
  end
  
  def play_game
    @game.greeting_message
  end
end

class TwoHeads
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end
  def greeting_message
    "Welcome to Two Heads game, it is #{@player1}'s turn"
  end
end

class SevenDie
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end
  def greeting_message
    "Welcome to Seven Die game, it is #{@player1}'s turn"
  end
end
