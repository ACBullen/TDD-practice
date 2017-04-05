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

  describe '#valid_move' do
    it 'returns a boolean' do
      result = game.valid_move(0, 1)
      expect([true,false].include?(result)).to eq(true)
    end
    it 'returns false when from tower is empty'do
      expect(game.valid_move(1,2)).to eq(false)
    end
    it 'returns false when the recieving tower top ring is smaller than moved ring' do
      game.move_rings(0,1)
      expect(game.valid_move(0,1)).to eq(false)
    end
    it 'returns false when either tower does not exist' do
      expect(game.valid_move(-1,5)).to eq(false)
    end

    it 'returns true for a valid move' do
      expect(game.valid_move(0, 1)).to eq(true)
    end
  end

  describe '#won?' do
    let(:move){
      game.move_rings(0,1)
      game.move_rings(0,2)
    }
    it 'returns false if there are still rings on the first tower' do
      expect(game.won?).to eq(false)
    end
    it 'returns false if neither of the last two towers are empty' do
      game.move_rings(1, 2)
      game.move_rings(0, 1)
      expect(game.won?).to eq(false)
    end
    it ' it returns true if all of the rings are on tower two or three' do
      game.towers = [[],[],[1,2,3]]
      expect(game.won?).to eq(true)
    end
  end

  # describe '#play' do
  #   before(:each) do
  #     game.towers = [[1],[],[2,3]]
  #     puts "This happened before"
  #   end
  #
  #   it 'calls to valid move' do
  #     #game.towers = [[1],[],[2,3]]
  #     expect(game).to receive(:valid_move)
  #     game.play
  #   end
  #
  #   it 'checks if the game is won' do
  #     expect(game).to receive(:won?)
  #     game.play
  #   end



  end


end
