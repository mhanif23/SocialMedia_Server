require_relative "../connector/db_connector"
class User
  attr_accessor :bio
  attr_reader :id, :created_at, :username, :email 

  def initialize()

  end
end