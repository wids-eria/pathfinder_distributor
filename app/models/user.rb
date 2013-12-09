class User < ActiveRecord::Base
  use_connection_ninja(:ada_database)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :authentication_keys => [:login]

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :player_name, :ada_id, :token, :iat, :control, :survey, :auth_token

  before_create :update_control_group
  before_save :ensure_authentication_token
  before_validation :set_email_from_player_name, :on => :create


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(player_name) = :login OR lower(email) = :login", login: login.strip.downcase]).first
  end

  def self.create_from_session(session)
    unless User.find_by_ada_id(session[:ada_id])
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

  def set_email_from_player_name
    return if self.email.present?
    return if self.player_name.blank?

    self.email = self.player_name + "@stu.de.nt"
  end
end
