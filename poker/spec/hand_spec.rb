require 'rspec'
require 'hand'
require 'byebug'

describe Hand do
  let(:deck) { Deck.new }
  subject(:hand) { Hand.new(deck) }

  describe '#initialize' do
    it 'draws 5 cards and adds them to its contents' do
      expect(hand.contents.length).to eq(5)
      expect(hand.contents.all?{ |card| card.is_a? Card }).to be(true)
    end
  end

  describe '#draw' do
    it 'raises an error if not passed a deck' do
      expect { hand.draw('dingdongs') }.to raise_error('That is not a valid deck')
    end

    it 'increases the size of the hand by one' do
      to_be_drawn = deck.contents.last
      hand.draw(deck)
      expect(hand.contents.length).to eq(6)
    end

    it 'adds the top card of the deck to the hand' do
      drawn = deck.contents.last
      hand.contents.map{|card| [card.val, card.suit]}
      hand.draw(deck)
      expect(hand.contents).to include(drawn)
    end

  end

  describe '#discard' do
    it 'raises an error if not passed an array' do
      expect{hand.discard('string')}.to raise_error(ArgumentError)
    end
    it 'raises an error if passed an invalid hand index' do
      expect{ hand.discard([-1, 8])}.to raise_error("Invalid index")
    end
    it 'discards the card(s) at the correct indexes' do
      hand.contents = [
        Card.new(7, :C),
        Card.new(4, :D),
        Card.new(3, :S),
        Card.new(1, :H),
        Card.new(7, :D)
      ]
      expected_hand = [
        Card.new(4, :D),
        Card.new(3, :S),
        Card.new(7, :D)
      ]
      hand.discard([0, 3])
      hand.contents -= expected_hand
      expect(hand.contents).to eq([])
    end
  end

  describe '#rank' do

    it 'recognizes a Full-house over a Three-of-a-kind' do
      hand.contents = []
      3.times do
        hand.contents << Card.new(3, :C)
      end
      2.times do
        hand.contents << Card.new(2, :D)
      end
      expect(hand.rank).to eq('Full-house')
    end

    it "recognizes a Straight Flush over a straight or a flush" do
      hand.contents = [
        Card.new(1, :D),
        Card.new(11, :D),
        Card.new(12, :D),
        Card.new(13, :D),
        Card.new(10, :D)

      ]

      expect(hand.rank).to eq('Straight Flush')
    end

    it "recognizes a high card" do
      hand.contents = [
        Card.new(2, :D),
        Card.new(3, :S),
        Card.new(4, :H),
        Card.new(5, :D),
        Card.new(7, :D)
      ]
      expect(hand.rank).to eq('High Card')
    end

    it "recognizes a Four-of-a-Kind" do
      hand.contents = [
        Card.new(1, :C),
        Card.new(1, :D),
        Card.new(1, :S),
        Card.new(1, :H),
        Card.new(7, :D)
      ]
      expect(hand.rank).to eq('Four-of-a-kind')
    end

    it "recognizes a Three-of-a-Kind" do
      hand.contents = [
        Card.new(2, :C),
        Card.new(1, :D),
        Card.new(1, :S),
        Card.new(1, :H),
        Card.new(7, :D)
      ]
      expect(hand.rank).to eq('Three-of-a-kind')
    end

    it "recognizes a Pair" do
      hand.contents = [
        Card.new(7, :C),
        Card.new(4, :D),
        Card.new(3, :S),
        Card.new(1, :H),
        Card.new(7, :D)
      ]
      expect(hand.rank).to eq('Pair')
    end

    it "recognizes a Two Pairs" do
      hand.contents = [
        Card.new(1, :C),
        Card.new(1, :D),
        Card.new(7, :S),
        Card.new(4, :H),
        Card.new(7, :D)
      ]
      expect(hand.rank).to eq('Two Pairs')
    end

    it "recognizes a Flush" do
      hand.contents = [
        Card.new(1, :C),
        Card.new(2, :C),
        Card.new(3, :C),
        Card.new(4, :C),
        Card.new(7, :C)
      ]
      expect(hand.rank).to eq('Flush')
    end

    it "recognizes a Straight" do
      hand.contents = [
        Card.new(1, :C),
        Card.new(2, :D),
        Card.new(3, :S),
        Card.new(4, :H),
        Card.new(5, :D)
      ]
      expect(hand.rank).to eq('Straight')
    end

  end


end
