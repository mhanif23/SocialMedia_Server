require "sinatra"
require_relative '../models/user'

class UserController
  def create(params)
    user = User.new(username: params[:username], email: params[:email])

    if !user.valid? 
      return (
        {
          status: 400,
          message: "bad request"
        }
      )
    end

    if user.exist? 
      return (
        {
          status: 400,
          message: "user with the same username is exist already"
        }
      )
    end

    if user.save
      return (
        {
          status: 201,
          message: "success"
        }
      )
    end
  end

  def find_user(params)
    user = User::find_user(params["username"])
    if user == nil
      return (
        {
          status: 404,
          message: "resource not found"
        }
      )
    end

    return (
      {
        status: 200,
        message: "success",
        data: user.make_hash
      }
    )
  end

  def update_bio(params)
    user = User::find_user(params["username"])
    if user == nil
      return (
        {
          status: 404,
          message: "resource not found"
        }
      )
    end
    user.set_bio(params["bio"])
    user.update()
    return (
      {
        status: 200,
        message: "success",
        data: user.make_hash
      }
    )
  end
end