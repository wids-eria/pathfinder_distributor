class User < ActiveRecord::Base
  #inlcude these devise modules to preserve the devise routes
  devise :registerable, :token_authenticatable, :authentication_keys => [:login]

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :player_name, :ada_id, :token, :iat, :control, :survey, :auth_token
  before_create :update_control_group

  def self.create_from_session(session)
    unless User.where(ada_id: session[:ada_id]).first
      return User.create(ada_id: session[:ada_id], player_name: session[:player_name], token: session[:token], auth_token: session[:auth])
    end
  end

  def pre
    count = AdaData.where({gameName: ENV['GameName_Pre'],user_id: self.ada_id, key: ENV['IAT_Flag']}).count()
    return count==0? false : true
  end

  def post
    count = AdaData.where({gameName: ENV['GameName_Post'],user_id: self.ada_id, key: ENV['IAT_Flag']}).count()
    return count==0? false : true
  end

  private

  def update_control_group
    if self.control.nil?
      if rand() < 0.5
        self.control = false
      else
        self.control = true
      end
    end

    true
  end
end
