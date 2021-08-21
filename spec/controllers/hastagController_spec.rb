require_relative "../../controllers/hastagController"

describe HastagController do
  it "find_trending" do 
    expected_response = {
      status: 200,
      message: "success",
      data: {hastag: "#luar"}
    }
    allow(Hastags).to receive(:find_trending).and_return({hastag: "#luar"})
    
    controller = HastagController.new
    response = controller.find_trending()
    expect(response).to eq(expected_response)
  end

  it "find_post_by_id" do 
    post = double
    posts = [post,post]
    expected_response = {
      status: 200,
      message: "success",
      data: posts
    }
    allow(Hastags).to receive(:post_contain_hastag).and_return(posts)
    
    controller = HastagController.new
    response = controller.find_post_by_id(hastag: "#luar")
    expect(response).to eq(expected_response)
  end
end