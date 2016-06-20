require 'set'

class Game

  ALPHABET = Set.new(("a".."z").to_a)
  MAX = 2
  attr_accessor :current_player, :dictionary

  def initialize(*players)
    word = File.readlines('dictionary.txt').map(&:chomp)
    @dictionary = Set.new(word)
    @fragment = ""
    @players = players
    @current_player = players.first
    @losses = {}
    @players.each {|player| @losses[player] = 0}
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

  def previous_player
    previous_player = current_player == @players.first ? @players.last : @players.first
  end

  def next_player
    @current_player = current_player == @players.first ? @players.last : @players.first
  end

  def play_turn
    letter = nil
    until letter && valid_play?(letter)
      letter = @current_player.guess
    end
    change_fragment(letter)
  end

  def play_round
    @fragment = ""
    until over?
      play_turn
      next_player
    end
    update_standings
  end

  def run
    @fragment = ""
    until game_over?
      play_round
    end
    puts "Game is over"
  end

  def game_over?
    @players.length == 1
  end

  def update_standings
    puts "#{previous_player.name} spelled #{@fragment}"
    puts "#{previous_player.name} gains a point"
    @losses[previous_player] += 1
    if @losses[previous_player] === MAX
      puts "Game is Over"
      puts "#{previous_player.name} has been eliminated"
      @players.delete(previous_player)
    end
    sleep(2)
  end

  def valid_play?(letter)
    return true if ALPHABET.include?(letter)
    false
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

game.run
