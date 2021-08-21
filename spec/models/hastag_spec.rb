require_relative "../../models/hastag.rb"

describe Hastags do
  before :each do
    @client = double
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end
  describe 'initialize' do
    before :each do
      @hastag_data = {hastag: '#liverpool'}
      @hastag = Hastags.new(
        hastag: @hastag_data[:hastag]
      )
    end
    it 'should give name attribute' do
      expect(@hastag.hastag).to be(@hastag_data[:hastag])
    end
  end

  describe 'get trending' do
    it 'should exec query' do
      query = "select Hastags.hastag, COUNT(id_hastag) as total_hastag FROM Hastag_contracts inner join Hastags on id_hastag = Hastags.id WHERE createdAt > (NOW() - INTERVAL 1 DAY)  GROUP BY hastag ORDER BY count(id_hastag) DESC LIMIT 5"
      expect(@client).to receive(:query).with(query).and_return([])
      expect(Hastags::find_trending()).to eq([])
    end
    it 'give object' do
      query = "select Hastags.hastag, COUNT(id_hastag) as total_hastag FROM Hastag_contracts inner join Hastags on id_hastag = Hastags.id WHERE createdAt > (NOW() - INTERVAL 1 DAY)  GROUP BY hastag ORDER BY count(id_hastag) DESC LIMIT 5"
      data = [{"hastag"=> "test"}]
      expect(@client).to receive(:query).with(query).and_return(data)
      expect(Hastags::find_trending().length).to eq(data.length)
    end
  end

  describe 'find id' do
    it 'should return id by hastag' do
      data = [{id: 1, hastag: "mantap"}]
      query = "select * from Hastags where hastag = 'mantap'"
      expect(@client).to receive(:query).with(query).and_return(data)
      respon = Hastags::find_id("mantap")
      # expect(respon).to eq(1)
    end
  end

  it 'save hastag' do
    hastag = Hastags.new(
        hastag: "cek"
      )
    allow(Hastags).to receive(:find_id).and_return(nil)
    query = "insert into Hastags (hastag) values ('cek')"
    allow(@client).to receive(:query).with(query)
    expect(hastag.save).to eq(true)
  end

  it 'exist' do
    hastag = Hastags.new(
        hastag: "#luar"
      )
    query = "SELECT COUNT(*) as count FROM Hastags WHERE hastag ='#luar'"
    allow(@client).to receive(:query).with(query).and_return([count: 1])
    expect(hastag.exist?).to eq(true)
  end
  
  it 'not exist' do
    hastag = Hastags.new(
        hastag: "#luar"
      )
    query = "SELECT COUNT(*) as count FROM Hastags WHERE hastag ='#luar'"
    allow(@client).to receive(:query).with(query).and_return({count: 0})
    expect(hastag.exist?).to eq(false)
  end
end