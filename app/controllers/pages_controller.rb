class PagesController < ActionController::Base
  append_view_path Page::Resolver.instance

  def show
    @page = params[:path].to_s.parameterize
    render @page, layout: 'boilerplate'
  end
end