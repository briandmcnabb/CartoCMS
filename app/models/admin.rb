class Admin < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :recoverable, :registerable, :rememberable, :timeoutable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end