# -*- encoding : utf-8 -*-
module AdminHelper

  def visibility_button(value)
    value == true ? image_tag('admin/visible.png') : image_tag('admin/invisible.png')
  end

  def color_presence_button(value)
    value == true ? image_tag('admin/colors1.png') : image_tag('admin/colors2.png')
  end

  def id_or_blank(property)
    property.id unless property.nil?
  end

  def human_status(status)
    return "Ожидает" if status == 'pending'
    return "Выполняется" if status == 'started'
    return "Выполнен" if status == 'finished'
  end
end
