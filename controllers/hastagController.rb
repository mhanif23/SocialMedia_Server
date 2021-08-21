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

  def find_post_by_id(params)
    posts = Hastags::post_contain_hastag(params[:hastag])
    return (
      {
        status: 200,
        message: "success",
        data: posts
      }
    )
  end
end