module ApplicationHelper

  def flash_class(type)
    case type
      when :alert
      "alert-danger"
      when :notice
      "alert-success"
      else
      ""
    end
  end

  def active_class(link_path)
      current_page?(link_path) ? "active" : ""
  end

end
