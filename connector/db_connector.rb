require 'mysql2'

def create_db_client
  client = Mysql2::Client.new(
    host: "localhost",
    username: "dev",
    password: "!2345Qwerty",
    database: "social_media"
  )
  client
end