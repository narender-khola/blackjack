require_relative 'card'

module BlackJack
  class Deck
    attr_accessor :deck
    def initialize
      reinit
    end

    def reinit
      ranks = (1..13).to_a
      suits = %w"S H D C"
      deck = suits.inject([]) do |deck, suit|
        deck << ranks.map{|rank| Card.new(rank,suit)}
      end.flatten
      @deck = ([] << deck << deck << deck << deck << deck << deck).flatten.shuffle
    end

    def draw
      @deck.pop
    end

    def up?
      @deck.size > 60
    end
  end
end