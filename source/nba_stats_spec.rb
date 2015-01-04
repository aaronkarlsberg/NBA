require_relative 'model'

describe 'Players & roster' do
  let(:player) {Player.new({name: 'Aaron', position: 'Forward', number: 00, points: 100 })}
  let(:nba_stats) {Roster.new("http://www.nba.com/lakers/stats")}

  describe 'player name' do
    it 'should return the player name' do
      expect(player.name).to eq("Aaron")
    end
  end

  describe 'roster' do

    it 'should return a roster that contains Player objects' do
      expect(nba_stats.roster.all?{|class_type| class_type.is_a?(Player)}).to eq(true)
    end

    it 'should return the first player name on the roster' do
      expect(nba_stats.roster[0].name).to eq ("Kobe Bryant")
    end

    it 'should return the number of players on the roster' do
      expect(nba_stats.roster.length).to eq (13)
    end

  end
end

