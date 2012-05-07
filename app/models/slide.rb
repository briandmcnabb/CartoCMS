class Slide
  # Slide [name, description, position]

  # Association
  belongs_to :slider
  has_one :image

end