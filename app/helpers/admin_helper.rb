module AdminHelper
  
  def visibility_button(value)
    value == true ? ' + ' : ' - '
  end
  
  def id_or_blank(property)
    property.id unless property.nil?
  end
  
  def four_digit_id(id)
    if id.to_s.length < 4
      until id.to_s.length == 4
        id = "0#{id}"
      end
      return id
    end
  end
end
