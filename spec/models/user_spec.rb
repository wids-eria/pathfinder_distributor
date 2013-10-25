require 'spec_helper'

describe User do
  let!(:user) { Fabricate :user,consented: true}

  it "pre IAT should be taken" do
    AdaData.where({gameName: ENV['GameName_Pre'],user_id: user.ada_id, key: ENV['IAT_Flag']}).create

    count = AdaData.where({gameName: ENV['GameName_Pre'],user_id: user.ada_id, key: ENV['IAT_Flag']}).count()
    count.should eq(1)
  end

  it "post IAT should be taken" do
    AdaData.where({gameName: ENV['GameName_Post'],user_id: user.ada_id, key: ENV['IAT_Flag']}).create

    count = AdaData.where({gameName: ENV['GameName_Post'],user_id: user.ada_id, key: ENV['IAT_Flag']}).count()
    count.should eq(1)
  end
end
