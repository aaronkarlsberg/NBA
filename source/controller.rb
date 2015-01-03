require_relative 'view'
require_relative 'model'

class Controller
  def initialize(stat_file)
    @roster = View.new(Roster.new(stat_file).roster)
  end

  def run
  puts "list players, list player or exit"
  input = gets.chomp
    while input != 'exit'
      condition = input.split(" ")[0..1].join(" ")
      args = input.split(" ")[2..-1].join(" ")
      if condition == 'list players'
        @roster.list_players
      elsif condition == "list player"
        @roster.list_player(args)
        end
        puts
        puts "list players, list player or exit"
        input = gets.chomp
     end
   end
end

