module SearchHelper
  
  def highlight_name technique, hit
    @name = hit["highlight"].present? && 
            hit["highlight"]["name"].present? &&
            hit["highlight"]["name"].first.present? ? hit["highlight"]["name"].try(:first) : technique.try(:name)    
  end
  
  def highlight_description technique, hit
    @description = hit["highlight"].present? && 
            hit["highlight"]["description"].present? &&
            hit["highlight"]["description"].first.present? ? hit["highlight"]["description"].try(:first) : technique.try(:description)
  end

end