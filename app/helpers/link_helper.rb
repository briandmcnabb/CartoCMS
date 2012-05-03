module LinkHelper

  def new_resource_link
    link_to new_resource_path, id: 'action_link', class: 'btn' do
      out = ""
      out << content_tag(:i, '', class: "icon-plus icon-white")
      out << "new"
      out.html_safe
    end
  end

  def link_to_modal(*args, &block)
    modal_data = { data: { toggle: 'modal', target: '#standard_modal' } }
    arg_index  = block_given? ? 1 : 2
    args[arg_index] = args[arg_index].merge(modal_data)
    link_to(*args, block)
  end

  def mercury_save_url
    id = params[:id] || current_page_id
    controller = "cms/#{params[:controller]}"
    url_for({controller: controller, action: 'update', id: id, only_path: false})
  end
end