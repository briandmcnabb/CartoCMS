class Cms::SlidesController < Cms::PositionableResourceController
  actions :all, except: [:index, :show, :new]
end