module ADADataHelpers
  def AddPreIAT(user)
    AdaData.where({gameName: ENV['GameName_Pre'],user_id: user.ada_id, key: ENV['IAT_Flag']}).create
  end

  def AddPostIAT(user)
    AdaData.where({gameName: ENV['GameName_Post'],user_id: user.ada_id, key: ENV['IAT_Flag']}).create
  end

  def FinishedIATs(user)
    AddPreIAT(user)
    AddPostIAT(user)
  end
end