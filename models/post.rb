require_relative "../connector/db_connector"
class Posts
  attr_accessor :caption, :attachment
  attr_reader :id, :id_user,:createdAt 

  def initialize(params)
    @id = params[:id]
    @id_user = params[:id_user]
    @caption = params[:caption]
    @attachment = params[:attachment]
    @createdAt = params[:createdAt]
  end

  def valid?
    return false if @id_user.nil? or @caption.nil? || @caption == "" || @caption.length >1000
    true
  end
end
  