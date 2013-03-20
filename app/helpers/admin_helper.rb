#encoding: utf-8
module AdminHelper

  def visibility_button(value)
    value == true ? image_tag('admin/visible.png') : image_tag('admin/invisible.png')
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
    return id
  end

  def human_status(status)
    return "Ожидает" if status == 'pending'
    return "Выполняется" if status == 'started'
    return "Выполнен" if status == 'finished'
  end
end
