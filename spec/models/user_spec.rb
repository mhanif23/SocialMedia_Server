require_relative "../../models/user.rb"
describe User do
  before :each do
    @client = double
    allow(Mysql2::Client).to receive(:new).and_return(@client)
  end
  
  describe "initialize" do
    context "give arguments" do 
      before :each do
        @user_data = {
          username: "Rizal",
          email: "rizal123@gmail.com"
        }
        @user = User.new(
          username: "Rizal",
          email: "rizal123@gmail.com"
        )
      end
      it 'should give username' do
        expect(@user.username).to eq(@user_data[:username])
      end
      it 'should give email' do
        expect(@user.email).to eq(@user_data[:email])
      end
      it 'should give empty bio' do 
        expect(@user.bio).to eq("")
      end
    end
  end
end