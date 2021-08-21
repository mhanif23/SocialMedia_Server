require_relative "../connector/db_connector"
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
    # return false unless self.valid? 

    # client = create_db_client
    # times = client.query("SELECT now()")
    # times do |time|
    #   createdAt = time["now()"]
    #   break
    # end
    # client.query(
    #   "INSERT INTO Users (id_user, caption, attachment,createdAt) VALUES ('#{@id_user}', '#{@caption}', '#{@attachment}','#{createdAt}')"
    # )

    # true
  end
  
  def find_hastag_from_caption
  end

  
end
  