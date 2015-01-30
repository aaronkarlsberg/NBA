require 'open-uri'
require 'nokogiri'

module Parser

    def self.convert_to_player_args(table_row)
      {
       name: table_row.css('.playerName').text,
       position: table_row.css('.playerPosition').text,
       number: table_row.css('.playerNumber').text,
       points: table_row.css('.pts').text,
       rebounds: table_row.css('.reb').text,
       assists: table_row.css('.ast').text
     }
    end

end
