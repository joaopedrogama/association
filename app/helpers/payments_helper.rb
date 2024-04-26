module PaymentsHelper

    def display_operation_errors(operation)
        if operation.errors.any?
          content_tag(:div, class: "alert alert-danger") do
            concat content_tag(:h2, "#{pluralize(operation.errors.count, 'error')} prohibited this #{operation.class.name.underscore} from being saved:")
            for error in operation.errors
              concat content_tag(:p, error.full_message)
            end
          end
        end
    end

end
