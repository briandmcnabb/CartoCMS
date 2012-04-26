module Mercury
  module Authentication

    def can_edit?
      admin_signed_in?
    end
  end
end
