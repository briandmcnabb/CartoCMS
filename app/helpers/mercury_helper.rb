module MercuryHelper
  def mercury_toggler
    if params[:controller] == 'pages' && user_signed_in?
      function = <<-EOS
        document.cookie='editing=#{is_editing? ? 'false' : 'true'}';
        top.location.href=top.location.href;
        return false;
      EOS

      content_tag :a, href: '#', onclick: function, id: 'mercury-toggler' do
        out = ""
        out << image_tag('CartoCMS/icon-nc-astrolabe.png', size: '40x40')
        out << (is_editing? ? 'Toggle Off Editor' : 'Edit Page Content')
        out.html_safe
      end
    end
  end

  def mercury_save_url
    id = params[:id] || current_page_id
    controller = "cms/#{params[:controller]}"
    url_for({controller: controller, action: 'update', id: id, only_path: false})
  end

  def mercury_edit_url
    path = @page.path.split('/')[1]
    url_for({ action: 'show', controller: '/pages', path: path, only_path: false, subdomain: false })
  end
end