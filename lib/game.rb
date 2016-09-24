require_relative 'player'
require_relative 'dealer'
require_relative 'hand'
require_relative 'deck'

module BlackJack
  class Game
    attr_accessor :players, :dealer, :deck, :player_count
    def initialize pCount
      pCount = pCount.to_i
      @player_count =  pCount + 1
      @players = []
      pCount.times do |i|
        print "Enter player#{i+1}'s name, gender & stack separated by comma : "
        @players << Player.new(*(STDIN.gets.chomp.split(",")), self)
      end
      @dealer = Dealer.new("Dealer", "F", 1<<64, self)
      @players << @dealer
      @deck = Deck.new
    end

    def request_card
      @deck.draw
    end

    def commence
      first_hand = true
      while @deck.up?
        if !first_hand
          print "\n\nDeal new hand? (y/n) : "
          input = STDIN.gets.chomp
        else
          input = "y"
          first_hand = false
        end
        system("clear")
        break if input == "n"
        next if input != "y"

        deal
        actions
        dealer_actions
        declare_winnners
        clear_hands
        reinit_deck
      end
    end

    def deal
      puts "DEALING CARDS...\n"
      sleep 2
      (@player_count*2 - 1).times do |i|
        card = @deck.draw
        player = @players[i%@player_count]
        player.hand.add card
      end
      @players.each do |player|
        puts "#{player.name}'s hand : #{player.hand.to_s}\n"
      end
    end

    def actions
      puts "\n\nACTIONS BEGIN..."
      sleep 1
      @players[0..-2].each do |player|
        player.action
      end
    end

    def dealer_actions
      alive_players = @players[0..-2].select{|p| p.status == :alive}
      return if alive_players.count < 1
      puts "Dealer actions...\n"
      @dealer.action
    end

    def declare_winnners
      alive_players = @players[0..-2].select{|p| p.status == :alive}
      winners = if @dealer.busted?
                  alive_players
                else
                  alive_players.select{|p| p.hand.sum > @dealer.hand.sum}
                end
      push_playes = @dealer.busted? ? [] : alive_players.select{|p| p.hand.sum == @dealer.hand.sum}
      if (winners.empty?)
        puts "\n#{@dealer.name} WINS!"
      else
        puts "\nWINNER(S) : " + winners.map{|w| "#{w.name}(#{w.hand.sum})"}.join(", ")
      end
      if !push_playes.empty?
        puts "\nPUSH at #{@dealer.hand.sum}: #{push_playes.map(&:name).join(", ")}"
      end
    end

    def clear_hands
      @players.each do |player|
        player.reinit
      end
    end

    def reinit_deck
      @deck.reinit if !@deck.up?
    end

  end
end

game = BlackJack::Game.new ARGV[0]
system("clear")
game.commence