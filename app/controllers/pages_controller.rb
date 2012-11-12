class PagesController < ActionController::Base
  before_filter :update_page_resolver

  prepend_view_path Page::Resolver.instance

  helper_method :is_editing?

  def show
    @page = params[:path].to_s.parameterize
    render @page, layout: layout_with_mercury
  end


private

  def is_editing?
    cookies[:editing] == 'true' && user_signed_in?
  end

  def layout_with_mercury(layout='boilerplate')
    !params[:mercury_frame] && is_editing? ? 'mercury' : layout
  end

  def update_page_resolver
    Page::Resolver.update_user_sign_in_status user_signed_in?
  end
end