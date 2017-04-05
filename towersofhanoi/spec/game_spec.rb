require 'rspec'
require 'game'

describe Game do
  subject(:game) {Game.new(3) }

  describe '#initialize' do

    it 'initializes with a given number of rings' do
      expect(game.towers).to eq([[1,2,3], [], []])
    end

  end

  describe '#move_rings' do
    it 'it transfers the last ring of one stack to the top of another' do
      game.move_rings(0,1)
      expect(game.towers).to eq([[2,3], [1], []])
    end
  end
end
