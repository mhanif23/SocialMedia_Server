require_relative "../connector/db_connector"
class Posts
  attr_accessor :caption, :attachment
  attr_reader :id, :id_user,:createdAt 

  def initialize(params)

  end
end
  