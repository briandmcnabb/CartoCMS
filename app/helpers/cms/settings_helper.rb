module Cms::SettingsHelper

  def settings_navigation
    Cms::SettingsController.descendants.map do |descendant|
      descendant = descendant.to_s.demodulize.downcase.gsub(/controller/, '')
      content_tag :li do
        link_to descendant.titleize, send("cms_setting_#{descendant.pluralize}_path")
      end
    end.join.html_safe
  end
end