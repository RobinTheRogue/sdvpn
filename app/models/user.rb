class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  validates :username, :uniqueness => {:case_sensitive => false}

  attr_accessor :signin

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => :signin.downcase }]).first
    end

end
