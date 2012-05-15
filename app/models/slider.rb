class Slider < ActiveRecord::Base
  #extend FriendlyId
  #friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Accessible Attributes
  attr_accessible :name, :description

  # Association
  has_many :slides

  # Validation
  validates :position, presence: true
  validates :name,     presence: true
end