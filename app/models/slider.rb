class Slider
  acts_as_list


  # Association
  has_many :slides

  # Nested Models
  accepts_nested_attributes_for :slides, reject_if: :all_blank, allow_destroy: true

  # Validation
  validates :position, presence: true
  validates :name,     presence: true
end