class Cms::TemplatesController < Cms::PositionableResourceController
  actions :all, except: [:show]
end