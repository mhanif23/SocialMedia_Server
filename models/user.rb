require_relative "../connector/db_connector"

class User
  attr_accessor :bio
  attr_reader :id, :created_at, :username, :email 

  def initialize(params)
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio] ? params[:bio] : ""
    @id = params[:id] ? params[:id] : ""
  end

  def valid?
    return false if @username.nil? or @username == ""
    return false if @email.nil? or @email == ""
    true
  end
  
  def save
    return false unless self.valid? 

    client = create_db_client
    client.query(
      "INSERT INTO Users (username, email, bio) VALUES ('#{@username}', '#{@email}', '#{@bio}')"
    )
    true
  end

  def exist?
    client = create_db_client
    rows = client.query(
      "SELECT COUNT(*) as count FROM Users WHERE username='#{@username}'"
    )
    return true if rows.first()["count"] > 0
    false
  end

  def self.find_user(username)
    client = create_db_client
    rows = client.query("SELECT * FROM Users WHERE username = '#{username}'")
    user = nil
    rows.each do |row|
      user = User.new(
        {
          username: row["username"],
          email: row["email"],
          bio: row["bio"],
          id: row["id"],
        }
      )
      break
    end
    user
  end

  def update
    return false unless valid?
    client = create_db_client
    client.query("UPDATE Users set bio = '#{@bio}' where username = #{@username}")
    true
  end

  def make_hash 
    {
      :id => @id,
      :username => @username,
      :email => @email,
      :bio => @bio
    }
  end

  def set_bio(params)
    @bio = params[:bio]
  end
end
