require_relative 'controller'
stat_file = Nokogiri::HTML(open("http://www.nba.com/lakers/stats"))

runner = Controller.new(stat_file)

runner.run