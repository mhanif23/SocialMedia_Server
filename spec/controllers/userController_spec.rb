require_relative "../../controllers/userController"

describe UserController do
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

  it "create success user" do 
    expected_response = {
      status: 201,  
      message: "success",
    }
    params = {
      "username" => @user_data["username"],
      "email" => @user_data["email"]
    }
    allow(@user).to receive(:valid?).and_return(true)
    allow(@user).to receive(:exist?).and_return(false)
    
    controller = UserController.new
    response = controller.create(params)
    expect(response).to eq(expected_response)
  end

  it "create success failed cause validation" do 
    expected_response = {
      status: 400,
      message: "bad request"
    }
    params = {
      "username" => @user_data["username"],
      "email" => @user_data["email"]
    }
    allow(@user).to receive(:valid?).and_return(false)
    allow(@user).to receive(:exist?).and_return(false)
    
    controller = UserController.new
    response = controller.create(params)
    expect(response).to eq(expected_response)
  end 

  it "create success failed cause exist" do 
    expected_response = {
      status: 400,
      message: "user with the same username is exist already"
    }
    params = {
      "username" => @user_data["username"],
      "email" => @user_data["email"]
    }
    allow(@user).to receive(:valid?).and_return(true)
    allow(@user).to receive(:exist?).and_return(true)
    
    controller = UserController.new
    response = controller.create(params)
    expect(response).to eq(expected_response)
  end 

  it "find user by username found" do 
    user_object = {
      id: @user_data["id"],
      username: @user_data["username"],
      email: @user_data["email"],
      bio: @user_data["bio"]
    }

    expected_response = {
      status: 200,  
      message: "success",
      data: user_object
    }

    allow(@user).to receive(:make_hash).and_return(user_object)

    controller = UserController.new
    response = controller.find_user(@user_data)
    expect(response).to eq(expected_response)
  end
end