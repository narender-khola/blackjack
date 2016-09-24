module BlackJack
  class Hand
    attr_accessor :cards
    def initialize
      @cards = []
    end
    def add card
      @cards << card
    end
    def to_s
      @cards.map(&:to_s).join(" ")
    end
    def sum
      non_aces = @cards.select{|card| card.rank != 1}
      aces = @cards - non_aces
      part_sum = non_aces.inject(0){|sum, card| sum+=card.value}
      return part_sum + aces.count if part_sum > 10
      return part_sum + (aces.empty? ? 0 : 10 + aces.count)
    end
  end
end