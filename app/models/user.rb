class User < ActiveRecord::Base
  #extend FriendlyId
  #friendly_id :email_local_part, use: [:slugged, :history]

  # Devise Modules
  devise :database_authenticatable, :invitable, :lockable, :recoverable, :registerable, :rememberable, :timeoutable, :trackable, :validatable

  # Accessors
  attr_accessible :email, :password, :password_confirmation


  private

  def email_local_part
    email.split('@').first
  end
end