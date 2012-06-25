class Slider < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  acts_as_list

  # Accessible Attributes
  attr_accessible :name, :description, :height, :width
  attr_accessor :height, :width

  # Association
  has_many :slides

  # Validation
  validates :name, presence: true

  # Callbacks
  before_save :set_aspect_ratio


private

  def set_aspect_ratio
    if height && width
      self.aspect_ratio = width.to_i.to_f / height.to_i.to_f
    end
  end
end