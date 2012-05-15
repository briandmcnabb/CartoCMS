class UserPresenter < ApplicationPresenter
  attributes_for :index, %w(email sign_in_count current_sign_in_at last_sign_in_at)
  attributes_for :form,  %w(email created_at)
  attributes_for :show,  %w(email created_at)

  #def body
  #  handle_none post.body do
  #    current_page?(posts_path) ? snippet(render_markdown(post.body), 80) : render_markdown(post.body)
  #  end
  #end
end