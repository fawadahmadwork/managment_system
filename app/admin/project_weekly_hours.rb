ActiveAdmin.register_page 'Project weekly hours' do
  menu false

  content title: 'Project logs' do
    project_id = params[:project_id]
    project = Project.find(project_id)

    if project
      weekly_hours = project.weekly_hours
      this_month_weekly_hours = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      total_weekly_hours = weekly_hours.sum(:hours)
      total_amount = weekly_hours.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee = weekly_hours.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost = weekly_hours.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount = weekly_hours.sum { |weekly_hour| weekly_hour.net_amount }
     
      monthly_weekly_hours = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum(:hours)
      monthly_total_amount = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.total_amount }
      monthly_total_fee = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.fee }
      monthly_total_external_cost = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.external_cost }
      monthly_total_net_amount = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.net_amount }



      panel 'Monthly Logs' do
        table do
          tr do
            th ' Monthly hours'
            th ' Monthly Gross Amount'
            th ' Monthly fee paid'
            th ' Monthly Externel cost'
            th ' Monthly Net Amount'
          end

          tr do
            td(monthly_weekly_hours)
            td(monthly_total_amount)
            td(monthly_total_fee)
            td(monthly_total_external_cost)
            td(monthly_total_net_amount)
          end
        end
     
 br
        
        table_for this_month_weekly_hours.order(week_date: :desc) do
          column('ID') { |wh| link_to(wh.id, admin_weekly_hour_path(wh)) }
          column('Date Range') { |wh| link_to(wh.date_range, admin_weekly_hour_path(wh)) }
          column('Project Rate') { |wh| wh.project.rate }
          column('Hours') { |wh| wh.hours }
          column('Total Amount') { |wh| wh.total_amount }
          column('Fee Percentage') { |wh| wh.project.fee_percentage }
          column('Fee') { |wh| wh.fee }
          column('External Rate') { |wh| wh.external_rate }
          column('External Cost') { |wh| wh.external_cost }
          column('Net Amount') { |wh| wh.net_amount }
        end
      end
br
br
     panel 'Total logs', style: 'font-size: 13px;' do
        table do
          tr do
            th ' Total hours'
            th ' Gross Amount'
            th ' fee paid'
            th ' Externel cost'
            th ' Net Amount'
          end

          tr do
            td(total_weekly_hours)
            td(total_amount)
            td(total_fee)
            td(total_external_cost)
            td(total_net_amount)
          end
        end
 
br
          table_for weekly_hours.order(week_date: :desc) do
          column('ID') { |wh| wh.id }
          column('Date Range') { |wh| link_to(wh.date_range, admin_weekly_hour_path(wh)) }
          column('Project Rate') { |wh| wh.project.rate }
          column('Hours') { |wh| wh.hours }
          column('Total Amount') { |wh| wh.total_amount }
          column('Fee Percentage') { |wh| wh.project.fee_percentage }
          column('Fee') { |wh| wh.fee }
          column('External Rate') { |wh| wh.external_rate }
          column('External Cost') { |wh| wh.external_cost }
          column('Net Amount') { |wh| wh.net_amount }
        end
      end
    else
      panel 'Project not found'
    end
  end
end

