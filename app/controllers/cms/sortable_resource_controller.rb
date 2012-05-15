class Cms::SortableResourceController < Cms::ResourceController
  has_scope :page,     default:  1, only: :index
  has_scope :per_page, default: 10, only: :index


  private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain.order("#{column} #{direction}")
      set_collection_ivar(c.respond_to?(:scoped) ? c.scoped : c.all)
    end
  end

  def column
    sanitized_column || 'created_at'
  end

  def direction
    sanitized_direction || 'desc'
  end

  def sanitized_column
    return params[:column] if resource_class.attribute_names.include?(params[:column])
  end

  def sanitized_direction
    return params[:direction] if %w[asc desc].include?(params[:direction])
  end
end