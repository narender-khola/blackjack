module BlackJack
  class Player
    attr_accessor :hand, :name, :gender, :stack, :game, :status
    def initialize name, gender, stack, game
      @name, @gender, @stack = name, gender, stack
      @game = game
      reinit
    end

    def reinit
      @status = :alive
      @hand = Hand.new
    end

    def hit card
      @hand << card
    end

    def busted?
      @status == :busted || @hand.sum > 21
    end

    def to_s
      "#{@name} | #{@hand.to_s} | #{@hand.sum}"
    end

    def action
      while true
        print "#{self.to_s} : HIT/STAND? (h/s) : "
        input = STDIN.gets.chomp
        break if input == "s"
        next if input != "h"
        @hand.add @game.request_card
        if @hand.sum > 21
          puts "#{self.to_s} | BUSTED!!!"
          @status = :busted
          break
        elsif @hand.sum == 21
          puts "#{self.to_s}"
          break
        end
      end
      puts ""
    end
  end
end