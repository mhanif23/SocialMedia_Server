require_relative "../../models/user.rb"
describe User do
  
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

  describe "save data to database" do
    before :each do
      @user = User.new(
        username: "Rizal",
        email: "rizal123@gmail.com",
        bio: "This is bio"
      )
      @user_data = {
          username: "Rizal",
          email: "rizal123@gmail.com",
          bio: "This is bio"
        }
      @client = double
      allow(Mysql2::Client).to receive(:new).and_return(@client)
      @query = "INSERT INTO Users (username, email, bio) VALUES ('#{@user_data[:username]}', '#{@user_data[:email]}', '#{@user_data[:bio]}')"
      allow(@client).to receive(:query).with(@query)
    end
    it 'instance execute the query and save data' do
      expect(@client).to receive(:query).with(@query)
      @user.save()
    end
    describe "Check Exist Databse" do
      before :each do
        @user = User.new(
          username: "Rizal",
          email: "rizal123@gmail.com",
          bio: "This is bio"
        )
        @user_data = {
            username: "Rizal",
            email: "rizal123@gmail.com",
            bio: "This is bio"
          }
        @client = double
        allow(Mysql2::Client).to receive(:new).and_return(@client)
        @query = "SELECT COUNT(*) as count FROM Users WHERE username='#{@user_data[:username]}'"
      end
      it 'instance execute the query return true' do
        query_result = double
        allow(query_result).to receive(:first).and_return({"count" => 1})
        allow(@client).to receive(:query).with(@query).and_return(query_result)
        expect(@user.exist?).to eq(true)
      end
      it 'instance execute the query return false' do
        query_result = double
        allow(query_result).to receive(:first).and_return({"count" => 0})
        allow(@client).to receive(:query).with(@query).and_return(query_result)
        expect(@user.exist?).to eq(false)
      end
    end
  end

  describe "Find user" do 
    before :each do
      @user_data = {
            id: 1,
            username: "Rizal",
            email: "rizal123@gmail.com",
            bio: "This is bio"
          }
      @query = "SELECT * FROM Users WHERE username = #{@user_data[:username]}"
      response = [{
          'id' => @user_data[:id],
          'username' => @user_data[:username],
          'email' => @user_data[:email],
          'bio' => @user_data[:bio]
        }
      ]
      @client = double
      allow(Mysql2::Client).to receive(:new).and_return(@client)
      allow(@client).to receive(:query).with(@query).and_return(response)
    end
    it 'should execute queries' do
      expect(@client).to receive(:query).with(@query)
      User::find_user(@user_data[:username])
    end
  end

  describe "update bio" do
    before :each do
      @user_data = {
            id: 1,
            username: "Rizal",
            email: "rizal123@gmail.com",
            bio: "This is bio"
          }
      @query = "UPDATE Users set bio = '#{@user_data[:bio]}' where username = #{@user_data[:username]}"
      @client = double
      allow(Mysql2::Client).to receive(:new).and_return(@client)
      allow(@client).to receive(:query).with(@query)
    end

    it "should update bio" do
      expect(@client).to receive(:query).with(@query)
      user = User.new(@user_data)
      user.update()
    end
  end
end