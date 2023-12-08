ActiveAdmin.register_page 'Monthly Logs' do
 content title: ' Project Logs' do
    # Initialize variables for total values
    total_weekly_hours_all = 0
    total_amount_all = 0
    total_fee_all = 0
    total_external_cost_all = 0
    total_net_amount_all = 0

    total_weekly_hours_current_month = 0
    total_amount_current_month = 0
    total_fee_current_month = 0
    total_external_cost_current_month = 0
    total_net_amount_current_month = 0

    total_weekly_hours_current_week = 0
    total_amount_current_week = 0
    total_fee_current_week = 0
    total_external_cost_current_week = 0
    total_net_amount_current_week = 0


    total_weekly_hours_current_year = 0
    total_amount_current_year = 0
    total_fee_current_year = 0
    total_external_cost_current_year = 0
    total_net_amount_current_year = 0

    # Iterate over all projects
    Project.all.each do |project|
      # Calculate totals for all projects
      project_weekly_hours = project.weekly_hours
      total_weekly_hours_all += project_weekly_hours.sum(:hours)
      total_amount_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.net_amount }

      # Calculate totals for the current month
      project_weekly_hours_current_month = project_weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      total_weekly_hours_current_month += project_weekly_hours_current_month.sum(:hours)
      total_amount_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.net_amount }

      # Calculate totals for the current week
      project_weekly_hours_current_week = project_weekly_hours.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week)
      total_weekly_hours_current_week += project_weekly_hours_current_week.sum(:hours)
      total_amount_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.net_amount }
    
      # Calculate totals for the current year
      project_weekly_hours_current_year = project_weekly_hours.where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year)
      total_weekly_hours_current_year += project_weekly_hours_current_year.sum(:hours)
      total_amount_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.net_amount }
    
    
    
    end

 
columns do
         column do

     # Display the total logs for the current week
     panel 'Current Week Total logs', style: 'font-size: 13px;' do
       table do
        tr do
          th 'Weekly logs'
          th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        tr do
          td 'Values'
          td(total_weekly_hours_current_week)
          td(total_amount_current_week)
          td(total_fee_current_week)
          td(total_external_cost_current_week)
          td(total_net_amount_current_week)
        end
      end
     end
    end 
  
      column do
    # Display the total logs for the current month
    panel 'Current Month Total logs', style: 'font-size: 13px;' do
      table do
        tr do
          th 'Monthly logs'
          th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        tr do
          td 'Values'
          td(total_weekly_hours_current_month)
          td(total_amount_current_month)
          td(total_fee_current_month)
          td(total_external_cost_current_month)
          td(total_net_amount_current_month)
        end
      end
    end
 end



  column do
   # Display the total logs for all projects
   # can also see the logs for the current year
    panel ' Current Year logs', style: 'font-size: 13px;' do
      table do
        tr do
          th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        tr do
          td(total_weekly_hours_current_year)
          td(total_amount_current_year)
          td(total_fee_current_year)
          td(total_external_cost_current_year)
          td(total_net_amount_current_year)
        end
      end
    end
  end

  end

        panel 'Projects Monthly Logs', class: 'custom-panel-heading' do
         table do
          tr do
          th 'Project Name'
          th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        Project.all.each do |project|
          # Calculate totals for the current week for each project
          project_weekly_hours_current_week = project.weekly_hours.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week)
          total_weekly_hours_current_week = project_weekly_hours_current_week.sum(:hours)
          total_amount_current_week = project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.total_amount }
          total_fee_current_week = project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.fee }
          total_external_cost_current_week = project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.external_cost }
          total_net_amount_current_week = project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.net_amount }

          tr do
            td { link_to project.name, admin_project_path(project) }
            td total_weekly_hours_current_week
            td total_amount_current_week
            td total_fee_current_week
            td total_external_cost_current_week
            td total_net_amount_current_week
          end
        end
      end
    end
  
  






panel 'Current Month Total logs', style: 'font-size: 13px;' do

end

   
end

end