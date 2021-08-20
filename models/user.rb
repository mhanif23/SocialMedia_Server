require_relative "../connector/db_connector"

class User
  attr_accessor :bio
  attr_reader :id, :created_at, :username, :email 

  def initialize(params)
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio] ? params[:bio] : ""
  end

  def valid?
    return false if @username.nil? or @username == ""
    return false if @email.nil? or @email == ""
    true
  end
  
  def save
    return false unless self.valid? 
    # return false unless self.user_exist?

    client = create_db_client
    client.query(
      "INSERT INTO Users (username, email, bio) VALUES ('#{@username}', '#{@email}', '#{@bio}')"
    )
  end

  def exist?
    client = create_db_client
    rows = client.query(
      "SELECT COUNT(*) as count FROM Users WHERE username='#{@username}'"
    )
    return true if rows.first()["count"] > 0
    false
  end
end