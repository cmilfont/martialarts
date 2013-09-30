module TechniquesHelper
  
  def owner? technique
    current_user && current_user.id == technique.user_id
  end
  
end