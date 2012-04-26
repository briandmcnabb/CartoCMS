class PagesController < ActionController::Base
  include Mercury::Authentication
  append_view_path Page::Resolver.instance

  helper_method :is_editing?
  helper_method :can_edit?


  def show
    @page = params[:path].to_s.parameterize
    render @page, layout: layout_with_mercury
  end




  private

  def layout_with_mercury(layout='boilerplate')
    !params[:mercury_frame] && is_editing? ? 'mercury' : layout
  end

  def is_editing?
    cookies[:editing] == 'true' && can_edit?
  end
end