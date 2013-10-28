module ADADataHelpers
  def AddPreIAT(user)
    AdaData.create({gameName: ENV['GameName_Pre'],user_id: user.ada_id, key: ENV['IAT_Flag']})
  end

  def AddPostIAT(user)
    AdaData.create({gameName: ENV['GameName_Post'],user_id: user.ada_id, key: ENV['IAT_Flag']})
  end

  def FinishedIATs(user)
    AddPreIAT(user)
    AddPostIAT(user)
  end
end