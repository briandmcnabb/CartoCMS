module TitleHelper

  def title(site_name, options={})
    action  = options[:action]  || dynamic_title
    divider = options[:divider] || '::' if action
    [site_name, divider, action].join(' ')
  end


  private

  def dynamic_title
    case controller.action_name
    when 'index' then index_title
    when 'show'  then show_title
    when 'new'   then new_title
    when 'edit'  then edit_title
    end
  end

  def index_title
    controller_name
  end

  def show_title
    params[:path].try(:capitalize) || "#{controller_name.singularize} #{params[:id]}"
  end

  def new_title
    "#{controller_action} #{controller_name.singularize}"
  end

  def edit_title
    "#{controller_action} #{controller_name.singularize} #{params[:id]}"
  end

  def controller_name
    params[:controller].split('/').last.capitalize
  end

  def controller_action
    params[:action].capitalize
  end
end
