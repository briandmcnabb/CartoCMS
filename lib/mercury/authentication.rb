module Mercury
  module Authentication

    def can_edit?
      user_signed_in?
    end
  end
end
