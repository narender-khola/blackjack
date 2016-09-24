module BlackJack
  class Card

    CLUB    = '♣'
    DIAMOND = '♦'
    HEART   = '♥'
    SPADE   = '♠'

    attr_accessor :rank, :suit, :value

    def initialize rank, suit
      @rank, @suit = rank, suit
      evaluate
    end

    def evaluate
      @value = if @rank > 1 && @rank < 10
                 @rank
               elsif @rank > 9
                 10
               else
                 11
               end
    end

    def to_s
      face_value
    end

    def face_value
      face = case @rank
               when 1
                 "A"
               when 11
                 "J"
               when 12
                 "Q"
               when 13
                 "K"
               else
                 @rank
             end
      suit = case @suit
               when "S"
                 SPADE
               when "H"
                 HEART
               when "D"
                 DIAMOND
               when "C"
                 CLUB
             end
      "#{face}#{suit}"
    end

  end
end