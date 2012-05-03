class Cms::<%= controller_class_name %>Controller < Cms::ResourceController
<% if options[:singleton] -%>
  defaults :singleton => true
<% end -%>
end