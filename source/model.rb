require_relative 'parser'
require_relative 'teams'

class Player
  attr_reader :name, :position, :number, :points, :rebounds, :assists
  def initialize(player = {})
    @name = player[:name]
    @position = player[:position]
    @number = player[:number]
    @points = player[:points]
    @rebounds = player[:rebounds]
    @assists = player[:assists]
  end

  def to_s
    "#{name} #{position} #{number} #{points} #{rebounds} #{assists}"
  end

  def selfish_score
    if @points.to_i > 180 && @assists.to_i > 1
      @points.to_f / @assists.to_f
    else
      0
    end
  end

  def unselfish_score
    if @points.to_i > 180 && @assists.to_i > 1
      @assists.to_f / @points.to_f
    else
      0
    end
  end

  def weighted_efficiency(points = 1, rebounds = 2.17, assists = 2.9)
    (@points.to_i * points) + (@rebounds.to_i * rebounds) + (@assists.to_i * assists)
  end

end

class Team
  attr_reader :name, :players

  @@teams = []

  def initialize(file, team)
    @name = team
    @players = []
    populate_roster(file)
    @@teams << self
  end

  def self.teams
    @@teams
  end

  def create_player(table_row)
    Player.new(Parser.convert_to_player_args(table_row))
  end

  def populate_roster(file)
    nokogiri_file = Nokogiri::HTML(open(file))
    nokogiri_file.search('.stats-table.player-stats.season-totals.table.table-striped.table-bordered.sticky-enabled tbody tr').each do |table_row|
    @players << create_player(table_row)
    #parses each row of the table into a hash. Then creates a new instance of player for each parsed row.
    end
  end
end

#roster is an array of players objects

@teams_array.each do |team|
  Team.new("http://www.nba.com/#{team}/stats", team)
end

#Team.new("http://www.nba.com/warriors/stats", "warriors")

# Team.teams.each do |team|
#   puts "#{team.name} has #{team.players.count} players"
# end

#p Team.teams
# puts "Initial team count: #{@teams_array.size}"
# puts "Downloaded team count: #{Team.teams.size}"

# I want to know which player has the most points

# my_team = Team.teams.find { |team| team.name == "warriors" }

# sorted_players = my_team.players.sort_by { |player| player.points.to_i }

# sorted_players.each { |player|
#   puts "#{player.name}: points:#{player.points} rebounds:#{player.rebounds} assists:#{player.assists} "
# }

#top 5 of each category

# top_five_points = my_team.players.sort_by { |player| player.points.to_i }[-5..-1]
# top_five_rebounds = my_team.players.sort_by { |player| player.rebounds.to_i }[-5..-1]
# top_five_assists = my_team.players.sort_by { |player| player.assists.to_i }[-5..-1]

# # p top_five_points
# # p top_five_rebounds
# # p top_five_assists

# #star_players = []
# my_team.players.each do |player|
#   puts "#{player.name} points:#{player.points} rebounds:#{player.rebounds} assists:#{player.assists}" if top_five_points.include?(player) && top_five_rebounds.include?(player) && top_five_assists.include?(player)
# end

#get all_players
all_players = []
Team.teams.each do |team|
  team.players.each do |player|
    all_players << player
  end
end

#get positions
positions = []
all_players.each do |player|
  positions << player.position
end
positions.uniq!

#print all selfish players
# all_players.sort { |a,b| b.selfish_score <=> a.selfish_score }[0..4].each do |player|
#   puts "#{player.name} -  selfish_score:#{player.selfish_score} points:#{player.points} assists:#{player.assists}"
# end

# positions.each do |position|
#   position_players = all_players.select {|player| player.position == position }
#   puts position
#   position_players.sort { |a,b| b.selfish_score <=> a.selfish_score }[0..4].each do |player|
#     puts "#{player.name} -  selfish_score:#{player.selfish_score} points:#{player.points} assists:#{player.assists}"
#   end
# end

# positions.each do |position|
#   position_players = all_players.select {|player| player.position == position }
#   puts position + "----------------"
#   position_players.sort { |a,b| b.unselfish_score <=> a.unselfish_score }[0..4].each do |player|
#     puts "#{player.name} -  unselfish_score:#{player.unselfish_score.round(3)} points:#{player.points} assists:#{player.assists}"
#   end
# end

all_players.sort { |a,b| b.weighted_efficiency <=> a.weighted_efficiency }[0..9].each do |player|
  puts "#{player.name} - weighted_efficiency:#{player.weighted_efficiency} points:#{player.points} assists:#{player.assists} rebounds: #{player.rebounds}"
end

#print all selfish players
# all_players.sort { |a,b| b.selfish_score <=> a.selfish_score }[0..4].each do |player|
#   puts "#{player.name} -  selfish_score:#{player.selfish_score} points:#{player.points} assists:#{player.assists}"
# end
