require_relative 'deck.rb'
class Hand

  HAND_RANKS = ['High Card', 'Pair', 'Two Pairs', 'Three-of-a-kind', 'Straight', 'Flush', 'Full-house', 'Four-of-a-Kind', 'Straight Flush']

  attr_accessor :contents
  def initialize(deck)
    @contents = []
    5.times do
      @contents << deck.draw
    end
  end

  def draw(deck)
    raise 'That is not a valid deck' unless deck.is_a?(Deck)
    @contents << deck.draw
  end

  def discard(card_idx_arr)
    raise ArgumentError unless card_idx_arr.is_a? Array
    raise "Invalid index" if card_idx_arr.any?{ |idx| !idx.between?(0,4) }
    uniq_indices = card_idx_arr.uniq

    uniq_indices.each do |idx|
      @contents[idx] = nil
    end

    @contents.compact!
  end

  def rank
    case true
    when flush? && straight?
      'Straight Flush'
    when four_of_a_kind?
      'Four-of-a-kind'
    when full_house?
      'Full-house'
    when flush?
      'Flush'
    when straight?
      'Straight'
    when three_of_a_kind?
      'Three-of-a-kind'
    when two_pairs?
      'Two Pairs'
    when pair?
      'Pair'
    else
      'High Card'
    end

  end



  def suits
    @contents.map(&:suit)
  end

  def values
    @contents.map(&:val)
  end
  
  private

  def straight?
    acemoddedvalues = values.map{|val| val == 1 ? 14 : val}
    values.sort.each_cons(2).all?{ |a, b| a == b - 1 } ||
    acemoddedvalues.sort.each_cons(2).all?{ |a, b| a == b - 1 }
  end

  def flush?
    suits.uniq.length == 1
  end

  def full_house?
    return true if pair? && three_of_a_kind?
  end

  def four_of_a_kind?
    values.any?{ |val| values.count(val) == 4 }
  end

  def pair?
    values.any?{ |val| values.count(val) == 2 }
  end

  def two_pairs?
    counter = 0
    values.each do |val|
      counter += 1 if values.count(val) == 2
    end

    counter == 4
  end

  def three_of_a_kind?
    values.any?{ |val| values.count(val) == 3 }
  end
end
