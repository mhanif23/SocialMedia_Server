require_relative "../connector/db_connector"

class Hastags
  attr_accessor :hastag
  
  def initialize(params)
    @hastag = params[:hastag]
  end

  def self.find_trending()
    client = create_db_client

    rows = client.query('select Hastags.hastag, COUNT(id_hastag) as total_hastag FROM Hastag_contracts inner join Hastags on id_hastag = Hastags.id WHERE createdAt > (NOW() - INTERVAL 1 DAY)  GROUP BY hastag ORDER BY count(id_hastag) DESC LIMIT 5')
    hastags = []

    rows.each do |row|
      hastag = Hastags.new(hastag: row['hastag'])
      hastags << hastag
    end
    hastags
  end
end