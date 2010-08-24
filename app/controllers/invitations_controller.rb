# This controller is used for teachers to confirm their invitation
class InvitationsController < ApplicationController
#   include Devise::Controllers::InternalHelpers
#   before_filter :require_no_authentication, :only => [:edit, :update]
#   before_filter :admin_required, :only => [:new, :create]
#   helper_method :after_sign_in_path_for
#   
#   ssl_required
#   
#   # GET /resource/invitation/new
#   def new
#     build_resource
#     render :new, :layout => 'admin'
#   end
#   
#   # POST /resource/invitation
#   def create
#     self.resource = resource_class.send_invitation(params[resource_name])
#     if resource.errors.empty?
#       set_flash_message :success, :send_instructions
#       redirect_to admin_teachers_path
#     else
#       render :new, :layout => 'admin'
#     end
#   end
#   
#   # GET /resource/invitation/accept?invitation_token=abcdef
#   def edit
#     self.resource = resource_class.new
#     resource.invitation_token = params[:invitation_token]
#     render_with_scope :edit
#   end
#   
#   # PUT /resource/invitation
#   def update
#     self.resource = resource_class.accept_invitation!(params[resource_name])
#     if resource.errors.empty?
#       set_flash_message :success, :updated
#       sign_in_and_redirect(resource_name, resource)
#     else
#       render_with_scope :edit
#     end
#   end
#   
# private
#   
#   def ssl_required?
#     %w[new create].include? action_name
#   end
#   
end