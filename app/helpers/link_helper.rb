module LinkHelper

  def action_link
    case controller.action_name
    when 'index' then link_to 'new', new_resource_path, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    when 'show'  then link_to 'back', :back, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    when 'new'   then link_to 'back', :back, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    when 'edit'  then link_to 'back', :back, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    end
  end

  def link_to_modal(*args, &block)
    modal_data = { data: { toggle: 'modal', target: '#standard_modal' } }
    arg_index  = block_given? ? 1 : 2
    args[arg_index] = args[arg_index].merge(modal_data)
    link_to(*args, block)
  end
end