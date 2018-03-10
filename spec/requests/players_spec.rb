require "rails_helper"

describe "Players API", :type => :request do
  before do
    @user = create(:user)
    @headers = {
      "Authorization": "bearer #{Auth.issue({user: @user.id})}"
    }
  end
  context "POST /api/players" do
    it "should fail if token not provided" do
      post "/api/players.json", params: { player: attributes_for(:player)}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should fail if first_name not present" do
      post "/api/players.json", params: { player: attributes_for(:player).except(:first_name)}, headers: @headers
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if last_name not present" do
      post "/api/players.json", params: { player: attributes_for(:player).except(:last_name)}, headers: @headers
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if rating not present" do
      post "/api/players.json", params: { player: attributes_for(:player).except(:rating)}, headers: @headers
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if handedness not present" do
      post "/api/players.json", params: { player: attributes_for(:player).except(:handedness)}, headers: @headers
      expect(response).to have_http_status(:conflict)
    end

    it "should fail if player with same name exists" do
      player = create(:player)
      post "/api/players.json", params: { player: attributes_for(:player)}, headers: @headers
      expect(response).to have_http_status(:conflict)
    end

    it "should deliver player if successful" do
      post "/api/players.json", params: { player: attributes_for(:player)}, headers: @headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(json['success']).to eq(true)
    end
  end

  context "GET /api/players" do
    it "should fail if token not provided" do
      get "/api/players.json"
      expect(response).to have_http_status(:unauthorized)
    end

    it "should deliver an empty array if no players" do
      player_one = create(:player)
      player_two = create(:player_two)
      get "/api/players.json", headers: @headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['players'].size).to eq(2)
    end

    xit "should deliver all players" do
      get "/api/players.json", headers: @headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['players']).to eq([])
    end

    xit "should not deliver players created by other users" do
    end
  end

  context "DELETE /players/:id" do
    xit "should fail if token not provided" do
    end

    xit "should fail if player does not exist" do
    end

    xit "should fail if player created by different user" do
    end

    xit "should remove the player if successful" do
    end
  end
end