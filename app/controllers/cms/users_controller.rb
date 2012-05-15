class Cms::UsersController < Cms::SortableResourceController
  actions :all, except: [:edit, :update]
end