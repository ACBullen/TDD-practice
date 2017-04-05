require 'card'
require 'rspec'

describe 'Card' do
  it 'initializes a card object with a value and a suit' do
    card = Card.new(10, :S)
    expect(card.suit).to eq(:S)
    expect(card.val).to eq(10)
  end
end
