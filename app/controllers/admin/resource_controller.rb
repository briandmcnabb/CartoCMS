class Admin::ResourceController < Admin::ApplicationController
  inherit_resources
  respond_to :html
  has_scope :page, default: 1
  self.responder = Admin::Responder
end