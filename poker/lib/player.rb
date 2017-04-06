require 'hand'
require 'deck'

class Player
  attr_reader :hand, :name, :pot
  def initialize(name, deck)
    @name = name
    @hand = Hand.new(deck)
    @pot = 500
  end

  def process_discard
    puts "#{@name}, please indicate which cards you would like to discard"
    begin
      desired_discards = gets.chomp.split(', ').map(&:to_i)
      @hand.discard(desired_discards)
    rescue
      puts 'Try again'
      retry
    end

    until @hand.contents.length == 5
      @hand.draw
    end
  end

  def get_betting_choice
    puts "Fold, raise, or see?"
    choice = gets.chomp.downcase
  end

  def raise_bet
    begin
      puts "Please enter an amount to raise."
      amount = gets.chomp.to_i
      raise 'Not enough cash' if amount > @pot
    rescue Exception => e
      puts e.message
      retry
    end
    @pot -= amount
    
    amount
  end
end
