# snippet.rb

teams = <<-eos
Atlanta Hawks
Boston Celtics
Charlotte Bobcats
Chicago Bulls
Cleveland Cavaliers
Denver Nuggets
Detroit Pistons
Golden State Warriors
Houston Rockets
Indiana Pacers
LA Clippers
LA Lakers
Memphis Grizzlies
Miami Heat
Milwaukee Bucks
Minnesota Timberwolves
New Jersey Nets
New Orleans Hornets
New York Knicks
Oklahoma City Thunder
Orlando Magic
Philadelphia Sixers
Phoenix Suns
Portland Trail Blazers
Sacramento Kings
San Antonio Spurs
Toronto Raptors
Utah Jazz
Washington Wizards
eos

@teams_array = []
teams.split("\n").each do |team|
  @teams_array << team.split(" ")[-1].downcase
end







