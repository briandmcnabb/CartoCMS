module LinkHelper

  def action_link
    case controller.action_name
    when 'index' then link_to 'new', new_resource_path, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    when 'show'  then link_to 'back', :back, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    when 'new'   then link_to 'back', :back, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    when 'edit'  then link_to 'back', :back, id: 'action_link', class: 'btn', data:{ page: "#{params[:action]}"}
    end
  end
end