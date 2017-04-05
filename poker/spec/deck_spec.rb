require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  describe '#initialize' do

    it 'initializes contents with 52 cards' do
      expect(deck.contents.length).to eq(52)
    end

    it 'Only contains cards in its contents' do
      expect(deck.contents.all?{ |card| card.is_a? Card }).to be(true)
    end

    it 'Each card in contents is unique' do
      testdeck = deck.contents.map{|card| [card.val, card.suit]}
      expect(testdeck).to eq(testdeck.uniq)
    end
  end

  describe '#shuffle' do
    it 'sets the contents to random order' do
      a = deck.contents.dup
      deck.shuffle
      expect(deck.contents).to_not eq(a)
    end
  end

  describe '#draw' do
    it 'returns a card' do
      expect(deck.draw.class).to eq(Card)
    end

    it 'decrements the deck by the card it drew' do
      drawn = deck.draw
      expect(deck.contents).not_to include(drawn)
    end

    it 'draws from the top of the deck' do
      prev_contents = deck.contents.dup

      expect(deck.draw).to eq(prev_contents.last)
    end

  end
end
