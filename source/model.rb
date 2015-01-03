require_relative 'parser'


class Player
  attr_reader :name, :position, :number, :points
  def initialize(player = {})
    @name = player[:name]
    @position = player[:position]
    @number = player[:number]
    @points = player[:points]
  end

  def to_s
    "#{name} #{position} #{number} #{points}"
  end
end


class Roster
  attr_reader :roster
  def initialize(file)
    @file = file
    @roster = []
    populate_roster
  end

  def new_player(table_row)
    Player.new(Parsers::NbaParser.new(table_row).player_fields)
  end

  def populate_roster
    @file.search('.stats-table.player-stats.season-totals.table.table-striped.table-bordered.sticky-enabled tbody tr').each do |table_row|
    roster << new_player(table_row)
    #parses each row of the table into a hash. Then creates a new instance of player for each parsed row.
    end
  end
end




# stat_file = Nokogiri::HTML(open("http://www.nba.com/bucks/stats"))

# test = Roster.new(stat_file)

# p test.roster

