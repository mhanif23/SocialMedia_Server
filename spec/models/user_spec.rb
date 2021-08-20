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
      it "should give username" do
        expect(@user.username).to eq(@user_data[:username])
      end
      it "should give email" do
        expect(@user.email).to eq(@user_data[:email])
      end
      it "should give empty bio" do 
        expect(@user.bio).to eq("")
      end
      it "should give bio when bio parameter has been inputted" do 
        user_data = {
          username: "Rizal",
          email: "rizal123@gmail.com",
          bio: "bio test"
        }
        user = User.new(user_data)
        expect(user.bio).to eq(user_data[:bio])
      end
    end
  end
  describe "validation" do 
    before :each do
      @user = User.new(
        username: "Rizal",
        email: "Rizal123@gmail.com"
      )
    end
    context "give valid argument" do 
      it "should return true" do
        expect(@user.valid?).to eq(true)
      end
    end
    context "give fail argument" do 
      it "should return false" do 
      @user_fail = User.new(
        username: "Rizal"
      )
        expect(@user_fail.valid?).to eq(false)
      end
      it "should return false" do 
        @user_fail = User.new(
          email: "Rizal123@gmail.com"
        )
          expect(@user_fail.valid?).to eq(false)
      end
      it "should return false" do 
        @user_fail = User.new(
          username: "Rizal",
          email: ""
        )
          expect(@user_fail.valid?).to eq(false)
        end
        it "should return false" do 
          @user_fail = User.new(
            email: "Rizal123@gmail.com",
            username: ""
          )
            expect(@user_fail.valid?).to eq(false)
          end
    end
  end
end