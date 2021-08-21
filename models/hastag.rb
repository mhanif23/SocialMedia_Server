require_relative "../connector/db_connector"

class Hastags
  attr_accessor :hastag
  
  def initialize(params)
    @hastag = params[:hastag]
  end

  def save
      client = create_db_client
      client.query("insert into Hastags (hastag) values ('#{@hastag}')")  
      true
  end

  def exist?
    client = create_db_client
    rows = client.query(
      "SELECT COUNT(*) as count FROM Hastags WHERE hastag ='#{@hastag}'"
    )
    return true if rows.first()["count"] > 0
    false
  end

  def self.find_trending()
    client = create_db_client

    datas = client.query('select Hastags.hastag, COUNT(id_hastag) as total_hastag FROM Hastag_contracts inner join Hastags on id_hastag = Hastags.id WHERE createdAt > (NOW() - INTERVAL 1 DAY)  GROUP BY hastag ORDER BY count(id_hastag) DESC LIMIT 5')
    hastags = []

    datas.each do |data|
      hastag = Hastags.new(hastag: data['hastag'])
      hastags << hastag.make_hash
    end
    hastags
  end

  def self.find_id(hastag)
    client = create_db_client
    hastags = client.query("select * from Hastags where hastag = '#{hastag}'")
    id = nil
    hastags.each do |data|
      id = data["id"]
      break
    end
    return id
  end

  def make_hash 
    {
      :hastag => @hastag
    }
  end
end