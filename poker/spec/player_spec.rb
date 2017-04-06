require 'rspec'
require 'player'

describe Player do
  let(:deck){ Deck.new }
  subject(:player) { Player.new('Horatio', deck) }
  describe '#initialize' do
    it 'initializes player hand to be a hand object' do
      expect(player.hand).to be_a(Hand)
    end

    it 'initializes player pot to 500' do
      expect(player.pot).to eq(500)
    end

    it 'sets the player name' do
      expect(player.name).to eq('Horatio')
    end
  end







end
