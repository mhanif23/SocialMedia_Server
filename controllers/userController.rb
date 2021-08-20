require '../models/user'
require "sinatra"

class UserController
  describe UsersController do
    before :each do
      @user = double
      @user_data = {
        "id" => 1,
        "username" => "Rizal",
        "email" => "Rizal@gmail.com",
        "bio" => "Test Bio!"
      }
      allow(@user).to receive(:id).and_return(@user_data["id"])
      allow(@user).to receive(:username).and_return(@user_data["username"])
      allow(@user).to receive(:email).and_return(@user_data["email"])
      allow(@user).to receive(:bio).and_return(@user_data["bio"])
      allow(@user).to receive(:save).and_return(true)
  
      allow(User).to receive(:find_user).and_return(@user)
  
      allow(User).to receive(:new).and_return(@user)
    end
  end
end