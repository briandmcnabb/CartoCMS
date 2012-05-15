class Cms::PageTemplatesController < Cms::PositionableResourceController
  actions :all, except: [:show]
end