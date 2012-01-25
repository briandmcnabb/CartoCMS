module Admin::StyleHelper  
  def odd_or_even
    { class: cycle("odd", "even", name: "rows") }
  end
end