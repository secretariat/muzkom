# -*- encoding : utf-8 -*-
module AdminHelper

  def availability_button( value, static )
    value = value.to_i
    static = static.to_i
    ret = nil
    case value
      when 1 ; ret = image_tag('admin/red.png', :class => "avaibility-button-inner yellow off") if value == static
      when 2 ; ret = image_tag('admin/green.png', :class => "avaibility-button-inner green off") if value == static
      when 3 ; ret = image_tag('admin/yellow.png', :class => "avaibility-button-inner yellow off") if value == static
      when 5 ; ret = image_tag('admin/quest.png', :class => "avaibility-button-inner quest off") if value == static
      # else return image_tag('admin/grey.png', :class => "avaibility-button-inner yellow off")
    end
    puts "val:#{value}\tsta:#{static}\tret#{ret}"
    sleep(1)
    return ret.blank? ? ret = image_tag('admin/grey.png', :class => "avaibility-button-inner yellow off") : ret
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
