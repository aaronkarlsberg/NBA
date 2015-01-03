class View
  def initialize(roster)
    @roster = roster
  end

  def list_player(player)
    if @roster.any? do |player_instance|
      player_instance.name.downcase == player.downcase
    end
      @roster.each do |player_instance|
      if player_instance.name.downcase == player.downcase
        puts player_instance.to_s
      end
    end
  else
      puts "player not found"
    end
  end

  def list_players
    @roster.each{|player| puts player.to_s }
  end
end
