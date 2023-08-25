ActiveAdmin.register SalaryDetailHistory do
  menu parent: 'salary'
  config.clear_action_items!
  index do
    selectable_column
    id_column
    column :name

    separator = '<br>from<br>'
    previous_values = {}
    columns_to_display = %i[basic_salary fuel medical_allownce house_rent opd arrears other_bonus gross_salary
                            provident_fund unpaid_leaves net_salary]

    columns_to_display.each do |field|
      column field.to_s.titleize do |salary_detail_history|
        current_value = salary_detail_history.send(field)
        prev_value = salary_detail_history.salary_structure.salary_detail_histories.order(id: :asc).where('id < ?',
                                                                                                          salary_detail_history.id).last&.send(field)

        value_display = if prev_value.present? && current_value.present? && prev_value != current_value
                          if prev_value < current_value
                            "<span style='color: green;'>#{current_value}</span>#{separator}<span style='color: red;'>#{prev_value}".html_safe
                          else
                            "<span style='color: red;'>#{current_value}</span>#{separator}<span style='color: green;'>#{prev_value}".html_safe
                          end
                        else
                          current_value
                        end

        previous_values[field] = current_value
        value_display
      end
    end
  end
end
