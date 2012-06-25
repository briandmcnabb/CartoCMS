class Cms::UsersController < Cms::SortableResourceController
  load_and_authorize_resource
  actions :all, except: [:new, :edit]
end