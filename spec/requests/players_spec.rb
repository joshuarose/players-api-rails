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
      player = create(:player, user: @user)
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
      get "/api/players.json", headers: @headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['players']).to eq([])
    end

    it "should deliver all players" do
      player_one = create(:player, user: @user)
      player_two = create(:player_two, user: @user)
      get "/api/players.json", headers: @headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['players'].size).to eq(2)
    end

    it "should not deliver players created by other users" do
      player_one = create(:player, user: @user)
      player_two = create(:player_two, user: create(:user_two))
      get "/api/players.json", headers: @headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['players'].size).to eq(1)
    end
  end

  context "DELETE /players/:id" do
    it "should fail if token not provided" do
      player_one = create(:player, user: @user)
      delete "/api/players/#{player_one.id}.json", params: { player: attributes_for(:player)}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should fail if player does not exist" do
      player_one = create(:player, user: @user)
      delete "/api/players/99999.json", params: { player: attributes_for(:player)}, headers: @headers
      expect(response).to have_http_status(:not_found)
    end

    it "should fail if player created by different user" do
      player_one = create(:player, user: @user)
      player_two = create(:player_two, user: create(:user_two))
      delete "/api/players/#{player_two.id}.json", params: { player: attributes_for(:player)}, headers: @headers
      expect(response).to have_http_status(:not_found)
    end

    it "should remove the player if successful" do
      player_one = create(:player, user: @user)
      delete "/api/players/#{player_one.id}.json", params: { player: attributes_for(:player)}, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end
end