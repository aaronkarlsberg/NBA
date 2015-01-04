require 'sqlite3'
require_relative 'model'

class Database
  def initialize(stat_file)
    @roster = Roster.new(stat_file).roster
    @nba_data = SQLite3::Database.new( "nba_data.db" )
    make_table
    insert_values
  end

  def make_table
    @nba_data.execute("CREATE TABLE 'nba_stats' (name STRING, position STRING, number STRING, points STRING);")
  end

  def insert_values
    @roster.each do |player|
      @nba_data.execute("INSERT INTO nba_stats VALUES (?, ?, ?, ?)", [player.name, player.position, player.number, player.points])
    end
  end

    def show_table_values
      @nba_data.execute('select * from nba_stats')
    end
end

stat_file = "http://www.nba.com/lakers/stats"

nba_table = Database.new(stat_file)

# puts nba_table.show_table_values












# testly = SQLite3::Database.new( "testly.db" )

# testly.execute("create table 'test' (number INTEGER);")

# array = [1,2,3,4,5]

# array.each do |x|
#   testly.execute("insert into test values (#{x})")
# end

# p testly.execute('select * from test')
