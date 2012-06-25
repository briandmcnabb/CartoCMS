class Connection < ActiveRecord::Base
  # Accessors
  attr_accessible :provider, :url

  # Associations
  belongs_to :connectable, polymorphic: true

  # Validations
  validates :provider, presence: true
  validates :username, presence: true
  validates :url,      presence: true

  # Callbacks
  before_validation(:on => :create) do
    self.username ||= self.url.split('/').last
  end
end
