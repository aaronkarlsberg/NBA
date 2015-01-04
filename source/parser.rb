require 'open-uri'
require 'nokogiri'

module Parsers
  class HtmlParser
    attr_reader :player_fields
    def initialize(table_row)
      @table_row = table_row
      @player_fields = {
       name: @table_row.css('.playerName').text,
       position: @table_row.css('.playerPosition').text,
       number: @table_row.css('.playerNumber').text,
       points: @table_row.css('.pts').text
     }
    end
  end
end
