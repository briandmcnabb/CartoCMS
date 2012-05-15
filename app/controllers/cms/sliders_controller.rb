class Cms::SlidersController < Cms::PositionableResourceController
  actions :all, except: [:show]
end