module ApplicationHelper
  
  def admin?
    current_user && current_user.admin?
  end
  
  def omniauth_authorize_path(resource_name, provider)
    send "#{resource_name}_omniauth_authorize_path", provider
  end
  
end
