require_relative "../connector/db_connector"
class Posts
  attr_accessor :caption, :attachment
  attr_reader :id, :id_user,:createdAt 

  def initialize(params)
    @id = params[:id]? params[:id] : ""
    @id_user = params[:id_user]
    @caption = params[:caption]
    @attachment = params[:attachment]
    @createdAt = params[:createdAt]
  end

  def valid?
    return false if @id_user.nil? or @caption.nil? || @caption == "" || @caption.length >1000
    true
  end

  def make_hash()
    {
      :id => @id,
      :id_user => @id_user,
      :caption => @caption,
      :attachment => @attachment,
      :createdAt => @createdAt
    }
  end

  def self.find_post_by_id(params)
    client = create_db_client
    post_datas = client.query("select * from Posts where id = #{params[:id]}")
    posts = []
    post_datas.each do |data|
      post = Posts.new(
      id: params[:id], 
      id_user: params[:id_user],
      caption: params[:caption],
      attachment: params[:attachment],
      createdAt: params[:createdAt],
      )
      posts << post
      break
    end
    posts
  end
end
  