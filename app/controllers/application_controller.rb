# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  def authorize_user!
    render_error_with("layouts/401", "Não autorizado!", :unauthorized) unless current_user.admin?
  end
  
  private
   def render_error_with page, message, status
     respond_to do |format|
       format.html {
         render page, :locals => { :message => message }, :status => status
       }
       format.json {
         render :json => {
           :message => message
         }, :status => status
       }
     end
   end
  
end
