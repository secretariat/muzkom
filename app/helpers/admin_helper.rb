module AdminHelper
  
  def visibility_button(value)
    value == true ? ' + ' : ' - '
  end
  
  def id_or_blank(property)
    property.id unless property.nil?
  end
end