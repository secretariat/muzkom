# -*- encoding : utf-8 -*-
module AdminHelper

  #def availability_button(value)
  #  return image_tag('admin/green.png') if value == 'avaible'
  #  return image_tag('admin/red.png') if value == 'notavaible'
  #  return image_tag('admin/yellow.png') if value == 'expecting'
  #  return image_tag('admin/quest.png') if value == 'check'
  #end
  def availability_button( value )
    case value
    when 1 ; return image_tag('admin/red.png')
    when 2 ; return image_tag('admin/green.png')
    when 3 ; return image_tag('admin/yellow.png')
    when 5 ; return image_tag('admin/quest.png')
    else
    end
  end

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
