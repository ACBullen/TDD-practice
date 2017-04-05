require_relative 'card'

class Deck
  attr_reader :contents

  def initialize
    @contents = []
    (1..13).each do |val|
      [:S, :D, :H, :C].each do |suit|
        @contents << Card.new(val, suit)
      end
    end
  end

  def shuffle
    @contents.shuffle!
  end

  def draw
    @contents.pop
  end

end
