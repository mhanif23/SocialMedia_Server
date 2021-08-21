require_relative "../../models/post.rb"
describe Posts do
  before :each do
    @posts_data = [
      {
        id: 3, 
        id_user: 1, 
        caption: 'Selamat siang para pelajar', 
        attachment: '/public/upload/test.jpg', 
        createdAt: '2021-08-20 11:48:38'
      },
      {
        id: 1, 
        id_user: 2, 
        caption: 'Selamat makans', 
        attachment: '/public/upload/test2.jpg', 
        createdAt: '2021-08-20 11:48:38'
      }
    ]
    @client = double
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end

  it 'should fullfill attributes initialize' do
    post_data = 
    post = Posts.new(
      id: @posts_data[0][:id], 
      id_user: @posts_data[0][:id_user],
      caption: @posts_data[0][:caption],
      attachment: @posts_data[0][:attachment],
      createdAt: @posts_data[0][:createdAt],
    )

    expect(post.id).to eq(@posts_data[0][:id])
    expect(post.id_user).to eq(@posts_data[0][:id_user])
    expect(post.caption).to eq(@posts_data[0][:caption])
    expect(post.attachment).to eq(@posts_data[0][:attachment])
    expect(post.createdAt).to eq(@posts_data[0][:createdAt])
  end

  context 'validation' do
    it 'return true' do
      post = Posts.new(
      id: @posts_data[0][:id], 
      id_user: @posts_data[0][:id_user],
      caption: @posts_data[0][:caption],
      attachment: @posts_data[0][:attachment],
      createdAt: @posts_data[0][:createdAt],
    )
    expect(post.valid?).to be(true)
    end
    it 'return false cause iduser nil' do
      post = Posts.new(
      id: @posts_data[0][:id],
      caption: @posts_data[0][:caption],
      attachment: @posts_data[0][:attachment],
      createdAt: @posts_data[0][:createdAt],
    )
    expect(post.valid?).to be(false)
    end
    it 'return false cause caption "" or nill' do
      post = Posts.new(
      id: @posts_data[0][:id], 
      id_user: @posts_data[0][:id_user],
      caption: "",
      attachment: @posts_data[0][:attachment],
      createdAt: @posts_data[0][:createdAt],
    )
    expect(post.valid?).to be(false)
    end
  end

end