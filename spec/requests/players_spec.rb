require "rails_helper"

describe "Players API", :type => :request do
  context "POST /api/players" do
    it "should fail if token not provided" do
      
    end

    xit "should fail if first_name not present" do
    end

    xit "should fail if last_name not present" do
    end

    xit "should fail if rating not present" do
    end

    xit "should fail if handedness not present" do
    end

    xit "should fail if player with same name exists" do
    end

    xit "should deliver player if successful" do
    end
  end

  context "GET /api/players" do
    xit "should fail if token not provided" do
    end

    xit "should deliver an empty array if no players" do
    end

    xit "should deliver all players" do
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