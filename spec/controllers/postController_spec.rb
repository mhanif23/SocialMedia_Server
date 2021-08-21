require_relative "../../controllers/postController"

describe PostController do
  before :each do
    @post = double
    @user_data = {
      "id_user" => 1,
      "caption" => "Rizal",
      "attachment" => "public/uploads/test",
      "file" => {}
    }
    allow(@post).to receive(:id_user).and_return(@user_data["id_user"])
    allow(@user).to receive(:caption).and_return(@user_data["caption"])
    allow(@user).to receive(:attachment).and_return(@user_data["attachment"])
    allow(@user).to receive(:file).and_return(@user_data["file"])
    allow(@user).to receive(:save).and_return(true)

    allow(User).to receive(:new).and_return(@user)
  end

  it 'create user' do
    allow(Time).to receive(:new).and_return("12021-08-21 18:31:27 ")
    post = double
    allow(Posts).to receive(:new).and_return(post)
    allow(post).to receive(:valid?).and_return(true)
    allow(post).to receive(:save).and_return(true)
    expected_response = {
      status: 201,  
      message: "success",
    }
    params = {
      id_user: 1,
      caption: "asd"
    }
    controller = PostController.new
    response = controller.create(params)
    allow(response).to eq(expected_response)
  end
end