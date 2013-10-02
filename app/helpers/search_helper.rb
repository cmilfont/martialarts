module SearchHelper
  
  def highlight_name technique
    @name = technique.try(:highlight).present? ? technique.try(:highlight)["name"] : nil
    @name.try(:first).present? ? @name.try(:first) : technique.try(:name)
  end
  
  def highlight_description technique
    @description = technique.try(:highlight).present? ? technique.try(:highlight)["description"]: nil
    @description.try(:first).present? ? @description.try(:first) : technique.try(:description)
  end

end