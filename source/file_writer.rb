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
        csv << ["name", "position", "number", "points"]
        @roster.each do |player|
          csv << [player.name, player.position, player.number, player.points]
        end
      end
    end
  end

    class SaveYAML
      def initialize(csv_file)
        @csv_file = csv_file
         # @csv_file = CSV.read(csv_file)
      end
      def save_as_yaml
        File.write('nba_stats.yaml', @csv_file.to_yaml)
      end
    end

    class SaveJSON
      def initialize(roster)
        @roster = roster
        save_as_json
      end

      def save_as_json
       File.open('nba_stats.json', 'w') do |file|
        @roster.each do |player|
          file.write(
            JSON.pretty_generate(
              "name" => player.name,
              "position" => player.position,
              "number" => player.number,
              "points" => player.points))
        end
      end
    end
  end

end

stat_file = "http://www.nba.com/lakers/stats"
player_list = Roster.new(stat_file).roster

csv = SavetoFiletype::SaveCSV.new(player_list)

json = SavetoFiletype::SaveJSON.new(player_list)

yaml = SavetoFiletype::SaveYAML.new(csv)





