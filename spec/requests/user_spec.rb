require "rails_helper"

describe "Users API", :type => :request do
  context "POST /api/user" do
    it "should fail if first_name not present" do
    end

    xit "should fail if last_name not present" do

    end

    xit "should fail if email not present" do

    end

    xit "should fail is passwords don't match" do
    end

    xit "should fail if user already exists" do
    end
    
    xit "should deliver user and token if successful" do
      
    end
  end

  context "POST /api/login" do
    xit "should fail if email not found" do
    end

    xit "should fail if password is invalid" do
    end

    xit "should deliver user and token if successful" do
      
    end
  end

  context "PUT /api/user/:userId" do
    xit "should update the user data" do
    end
  end
end


# it "should fail if first_name not present" do
#   headers = {
#     "ACCEPT" => "application/json",     # This is what Rails 4 accepts
#     "HTTP_ACCEPT" => "application/json" # This is what Rails 3 accepts
#   }
#   post "/widgets", :params => { :widget => {:name => "My Widget"} }, :headers => headers

#   expect(response.content_type).to eq("application/json")
#   expect(response).to have_http_status(:created)
# end