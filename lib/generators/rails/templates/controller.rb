class Admin::<%= controller_class_name %>Controller < Admin::ResourceController
<% if options[:singleton] -%>
  defaults :singleton => true
<% end -%>
end