require 'set'

class Game

  ALPHABET = Set.new(("a".."z").to_a)

  attr_accessor :current_player, :dictionary

  def initialize(*players)
    word = File.readlines('dictionary.txt').map(&:chomp)
    @dictionary = Set.new(word)
    @fragment = ""
    @players = players
    @current_player = players.first
  end

  def over?
    @dictionary.include?(@fragment)
  end

  def change_fragment(letter)
    @fragment += letter
  end

  def current_player
    @current_player
  end

  def next_player
    @current_player = current_player == @players.first ? @players.last : @players.first
  end

  def play_turn
    letter = nil
    until letter
      letter = @current_player.guess
      if (valid_play?(letter))
        next
      end
    end
    change_fragment(letter)
  end

  def play_round

    until over?
      play_turn
      next_player
    end
    puts "Game over"
  end

  def valid_play?(letter)
    return true if ALPHABET.include?(letter)
    true
  end

end




class Player

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "Hello #{@name}, please enter your guess:"
    guess = gets.chomp
  end


end


p1 = Player.new("first")
p2 = Player.new("second")
game = Game.new(p1,p2)

game.play_round
