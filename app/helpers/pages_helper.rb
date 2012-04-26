module PagesHelper

  def current_page_id
    Page::Resolver.instance.instance_eval('@cached').to_s.split(' - ')[1]
  end
end