require_relative 'model'
require 'csv'
require 'yaml'
require 'json'

module SavetoFiletype

  class SaveCSV
    def initialize(roster)
      @roster = roster
      save_as_csv
    end

    def save_as_csv
      CSV.open('nba_stats.csv', 'wb') do |csv|
        csv << ["name", "position", "number", "points", "rebounds", "assists"]
        @roster.each do |player|
          csv << [player.name, player.position, player.number, player.points, player.rebounds, player.assists]
        end
      end
    end
  end
end


stat_file = "http://www.nba.com/lakers/stats"
player_list = Roster.new(stat_file).roster

csv = SavetoFiletype::SaveCSV.new(player_list)

# json = SavetoFiletype::SaveJSON.new(player_list)

# yaml = SavetoFiletype::SaveYAML.new(csv)





