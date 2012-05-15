module Cms::SortHelper
  def sortable(column, options={})
    title  = options[:title]  || column.titleize
    remote = options[:remote] || false
    css_class = column == params[:column] ? "current #{ params[:direction] }" : nil
    direction = column == params[:column] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, params.merge(column: column, direction: direction, page: nil), { remote: remote, class: css_class }
  end
end