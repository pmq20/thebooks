# -*- encoding : utf-8 -*-
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Redis::Objects
  extend OmniauthCallbacks
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  
  field :name
  validate :name_okay_check
  def name_okay_check
    if Util.js_strlen(self.name)>12
      errors.add(:name,"不能多于6个汉字或者12个字符")
      return false
    end
    if Util.js_chinese(self.name)<2
      errors.add(:name,"不是真实中文姓名")
      return false
    end
    if !WebService.name_okay?(self.name)
      errors.add(:name,"请输入真实中文姓名<br><span style=\"font-size:12px\">(如果系统误判你的姓名，请换个名字先注册，注册后可再改名)</span>")
      return false
    end
  end
  embeds_many :authorizations
  field :nickname
  field :location
  field :tagline
end
