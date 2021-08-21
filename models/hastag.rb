require_relative "../connector/db_connector"


class Hashtag
  attr_accessor :name, :hastag_used
  
  def initialize(params)
    @name = params[:name]
  end

  def self.find_trending

  end
end