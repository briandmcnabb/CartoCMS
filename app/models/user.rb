class User < ActiveRecord::Base
  # FriendlyID
  extend FriendlyId
  friendly_id :email_local_part, use: [:slugged, :history]

  # Devise Modules
  devise :database_authenticatable, :invitable, :lockable, :recoverable, :registerable, :rememberable, :timeoutable, :trackable, :validatable

  # Accessors
  attr_accessible :admin, :email, :password, :password_confirmation, :time_zone

  # Validations
  #validates :password, confirmation: true
  #validates :current_password, presence: true

  # Set Timezone
  def set_timezone(force = false)
    if self.current_sign_in_ip && (force || self.time_zone.blank?)
      coordinates  = Geocoder.search(self.current_sign_in_ip).first.coordinates
      timezone     = Timezone::Zone.new(latlon: coordinates) unless [0.0, 0.0]
      self.update_attribute(:time_zone, timezone) if timezone
    end
  end


  private

  def email_local_part
    email.split('@').first
  end
end