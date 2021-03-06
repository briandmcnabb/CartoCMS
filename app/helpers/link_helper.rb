module LinkHelper

  def link_to_modal(*args, &block)
    modal_data = { data: { toggle: 'modal', target: '#standard_modal' } }
    arg_index  = block_given? ? 1 : 2
    args[arg_index] = args[arg_index].merge(modal_data)
    link_to(*args, &block)
  end

  def new_resource_link
    if @new_resource_link_config.try(:fetch, :modal)
      link_to_modal '#', class: 'btn btn-small-dark' do
        out = ""
        out << content_tag(:i, '', class: "icon-plus icon-white")
        out << (@new_resource_link_config[:text] || "new")
        out.html_safe
      end
    else
      link_to new_resource_path, class: 'btn btn-small-dark' do
        out = ""
        out << content_tag(:i, '', class: "icon-plus icon-white")
        out << (@new_resource_link_config.try(:fetch, :text) || "new")
        out.html_safe
      end
    end
  end

  def panel_back_path(path=[:cms, resource_class])
    @panel_back_path ||= path
  end
end