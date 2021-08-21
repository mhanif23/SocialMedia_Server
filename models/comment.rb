require_relative "../connector/db_connector"
require_relative "./hastag"
class Comment
  attr_accessor :comment, :attachment
  attr_reader :id, :id_user,:createdAt 

  def initialize(params)
    @id = params[:id]? params[:id] : ""
    @id_user = params[:id_user]
    @id_post = params[:id_post]
    @comment = params[:comment]
    @attachment = params[:attachment] ? params[:attachment] : ""
    @createdAt = params[:createdAt] ? params[:createdAt] : ""
  end

  def valid?
    return false if @id_user.nil? or @comment.nil? || @comment == "" || @comment.length >1000 || @id_post.nil? || @id_post == ""
    true
  end

  def make_hash()
    {
      :id => @id,
      :id_user => @id_user,
      :id_post => @id_post,
      :comment => @comment,
      :attachment => @attachment,
      :createdAt => @createdAt
    }
  end

  def self.find_post_by_id(params)
    client = create_db_client
    comment_datas = client.query("select * from Comments where id = #{params[:id]}")
    comments = []
    comment_datas.each do |data|
      comment = Comment.new(
      id: params[:id], 
      id_user: params[:id_user],
      id_post: params[:id_post],
      comment: params[:comment],
      attachment: params[:attachment],
      createdAt: params[:createdAt],
      )
      comments << comment
      break
    end
    comments
  end

  def save
    return false unless self.valid? 
    puts "DI SAVE LOH"
    client = create_db_client
    client.query(
      "INSERT INTO Comments (id_user, id_post, comment ,attachment) VALUES (#{@id_user},#{@id_post},'#{@comment}', '#{@attachment}')"
    )
    id_comment = client.last_id
    hastags = find_hastag_from_comment(@comment)
    hastags.each do |hastag|
      hastag_obj = Hastags.new(hastag: hastag)
      hastag_obj.save if !hastag_obj.exist?
      id = Hastags::find_id(hastag)
      client.query(
      "INSERT INTO Hastag_contracts (id_comment, id_hastag) VALUES (#{id_comment}, #{id})"
      ) 
    end
    true
  end
  
  def find_hastag_from_comment(comment)
    comment.downcase.scan(/#[a-zA-Z]+/).uniq
  end
end
  