require "rails_helper"

describe "Users API", :type => :request do
  context "POST /api/user" do
    it "should fail if first_name not present" do
      post "/api/user.json", params: { user: attributes_for(:user).except(:first_name)}
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if last_name not present" do
      post "/api/user.json", params: { user: attributes_for(:user).except(:last_name)}
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if email not present" do
      post "/api/user.json", params: { user: attributes_for(:user).except(:email)}
      expect(response).to have_http_status(:conflict)
    end

    it "should fail is passwords don't match" do
      post "/api/user.json", params: { user: attributes_for(:user).merge(password: "noobar")}
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if user already exists" do
      user = create(:user)
      post "/api/user.json", params: { user: attributes_for(:user).merge(password: "noobar")}
      expect(response).to have_http_status(:conflict)
    end
    
    it "should deliver user and token if successful" do
      post "/api/user.json", params: { user: attributes_for(:user)}
      json = JSON.parse(response.body)
      user = User.find_by_email(build(:user).email)
      expect(response).to have_http_status(:created)
      expect(json['success']).to eq(true)
      expect(json['user']['id']).to eq(user.id)
    end
  end

  context "POST /api/login" do
    it "should fail if email not found" do
      post "/api/login.json", params: { email: 'notfound@gmail.com', password: 'foobar123'}
      expect(response).to have_http_status(:not_found)
    end

    it "should fail if password is invalid" do
      user = create(:user)
      post "/api/login.json", params: { email: user.email, password: 'password'}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should deliver user and token if successful" do
      user = create(:user)
      post "/api/login.json", params: { email: user.email, password: 'foobar123'}
      json = JSON.parse(response.body)
      user = User.find_by_email(build(:user).email)
      expect(response).to have_http_status(:ok)
      expect(json['success']).to eq(true)
      expect(json['user']['id']).to eq(user.id)
    end
  end

  context "PUT /api/user/:userId" do
    it "should return not found for invalid user id" do
      user = create(:user)
      headers = {
        "Authorization": "bearer #{Auth.issue({user: user.id})}"
      }
      put "/api/user/999999999.json", params: { user: { first_name: 'Elon', last_name: 'Musk' }}, headers: headers
      expect(response).to have_http_status(:not_found)
    end

    it "should return unauthorized for no JWT" do
      user = create(:user)
      put "/api/user/#{user.id}", params: { user: { first_name: 'Elon', last_name: 'Musk' }}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return unauthorized for invalid JWT" do
      user = create(:user)
      headers = {
        "Authorization": "bearer BADTOKEN"
      }
      expect {
        put "/api/user/#{user.id}", params: { user: { first_name: 'Elon', last_name: 'Musk' }}, headers: headers
      }.to raise_error(JWT::DecodeError)
    end
    
    it "should update the user data" do
      user = create(:user)
      headers = {
        "Authorization": "bearer #{Auth.issue({user: user.id})}"
      }
      put "/api/user/#{user.id}.json", params: { user: { first_name: 'Elon', last_name: 'Musk' }}, headers: headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json['success']).to eq(true)
      expect(json['user']['id']).to eq(user.id)
      expect(json['user']['first_name']).to eq('Elon')
      expect(json['user']['last_name']).to eq('Musk')
    end
  end
end