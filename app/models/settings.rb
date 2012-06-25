class Settings < ActiveRecord::Base
  acts_as_singleton

  has_many :connections, as: :connectable, dependent: :destroy
end
