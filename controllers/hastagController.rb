require "sinatra"
require_relative '../models/hastag'

class HastagController
  def find_trending
    trending = Hastags::find_trending()
    return (
      {
        status: 200,
        message: "success",
        data: trending
      }
    )
  end
end