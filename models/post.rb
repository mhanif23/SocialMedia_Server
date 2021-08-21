require_relative "../connector/db_connector"
require_relative "./hastag"
class Posts
  attr_accessor :caption, :attachment
  attr_reader :id, :id_user,:createdAt 

  def initialize(params)
    @id = params[:id]? params[:id] : ""
    @id_user = params[:id_user]
    @caption = params[:caption]
    @attachment = params[:attachment] ? params[:attachment] : ""
    @createdAt = params[:createdAt] ? params[:createdAt] : ""
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

  def save
    return false unless self.valid? 

    client = create_db_client
    client.query(
      "INSERT INTO Posts (id_user,caption,attachment) VALUES (#{@id_user},'#{@caption}', '#{@attachment}')"
    )
    id_post = client.last_id
    hastags = find_hastag_from_caption(@caption)
    hastags.each do |hastag|
      hastag_obj = Hastags.new(hastag: hastag)
      hastag_obj.save if !hastag_obj.exist?
      id = Hastags::find_id(hastag)
      client.query(
      "INSERT INTO Hastag_contracts (id_post, id_hastag) VALUES (#{id_post}, #{id})"
      ) 
    end
    true
  end
  
  def find_hastag_from_caption(caption)
    caption.downcase.scan(/#[a-zA-Z]+/).uniq
  end

  
end
  