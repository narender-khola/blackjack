module BlackJack
  class Dealer < Player
    def action
      while true
        puts "#{self.to_s}"
        sleep 1
        break if @hand.sum > 16
        @hand.add @game.request_card
        if @hand.sum > 21
          puts "#{self.to_s} | BUSTED!!!"
          @status = :busted
          break
        elsif @hand.sum > 16
          puts "#{self.to_s}"
          break
        end
      end
    end
  end
end