class Admin::AssetsController < Admin::CartoAssetsController
  optional_belongs_to :page
end