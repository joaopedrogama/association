module ApplicationHelper
    def display_active_status(object)
      if object.active
        content_tag(:span, class: "text-success") do
          content_tag(:i, "", class: "bi bi-check-circle")
        end
      else
        content_tag(:span, class: "text-danger") do
          content_tag(:i, "", class: "bi bi-x-circle")
        end
      end
    end
end
