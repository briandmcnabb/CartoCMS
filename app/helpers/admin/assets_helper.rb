module Admin::AssetsHelper

  def carto_assets_uploader
    render 'admin/assets/index'
  end

  def parent_resource
    if respond_to? ('parent')
      parent
    elsif respond_to? ('resource')
      resource
    else
      nil
    end
  end
end