module LinkHelper

  def new_resource_link
    if content_for?(:new_resource_link)
      content_for(:new_resource_link)
    else
      link_to new_resource_path, class: 'btn btn-small-dark' do
        out = ""
        out << content_tag(:i, '', class: "icon-plus icon-white")
        out << "new"
        out.html_safe
      end
    end
  end

  def link_to_modal(*args, &block)
    modal_data = { data: { toggle: 'modal', target: '#standard_modal' } }
    arg_index  = block_given? ? 1 : 2
    args[arg_index] = args[arg_index].merge(modal_data)
    link_to(*args, block)
  end
end