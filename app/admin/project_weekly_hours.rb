# ActiveAdmin.register_page 'Project weekly hours' do
#   menu false

#   content title: 'Project logs' do
#     project_id = params[:project_id]
#     project = Project.find(project_id)

#     if project
#       weekly_hours = project.weekly_hours
#       this_month_weekly_hours = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
#       total_weekly_hours = weekly_hours.sum(:hours)
#       total_amount = weekly_hours.sum { |weekly_hour| weekly_hour.total_amount }
#       total_fee = weekly_hours.sum { |weekly_hour| weekly_hour.fee }
#       total_external_cost = weekly_hours.sum { |weekly_hour| weekly_hour.external_cost }
#       total_net_amount = weekly_hours.sum { |weekly_hour| weekly_hour.net_amount }
     
#       monthly_weekly_hours = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum(:hours)
#       monthly_total_amount = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.total_amount }
#       monthly_total_fee = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.fee }
#       monthly_total_external_cost = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.external_cost }
#       monthly_total_net_amount = weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.net_amount }



#       panel 'Monthly Logs' do
#         table do
#           tr do
#             th ' Monthly hours'
#             th ' Monthly Gross Amount'
#             th ' Monthly fee paid'
#             th ' Monthly Externel cost'
#             th ' Monthly Net Amount'
#           end

#           tr do
#             td(monthly_weekly_hours)
#             td(monthly_total_amount)
#             td(monthly_total_fee)
#             td(monthly_total_external_cost)
#             td(monthly_total_net_amount)
#           end
#         end
     
#  br
        
#         table_for this_month_weekly_hours.order(week_date: :desc) do
#           column('ID') { |wh| link_to(wh.id, admin_weekly_hour_path(wh)) }
#           column('Date Range') { |wh| link_to(wh.date_range, admin_weekly_hour_path(wh)) }
#           column('Project Rate') { |wh| wh.project.rate }
#           column('Hours') { |wh| wh.hours }
#           column('Total Amount') { |wh| wh.total_amount }
#           column('Fee Percentage') { |wh| wh.project.fee_percentage }
#           column('Fee') { |wh| wh.fee }
#           column('External Rate') { |wh| wh.external_rate }
#           column('External Cost') { |wh| wh.external_cost }
#           column('Net Amount') { |wh| wh.net_amount }
#         end
#       end
# br
# br
#      panel 'Total logs', style: 'font-size: 13px;' do
#         table do
#           tr do
#             th ' Total hours'
#             th ' Gross Amount'
#             th ' fee paid'
#             th ' Externel cost'
#             th ' Net Amount'
#           end

#           tr do
#             td(total_weekly_hours)
#             td(total_amount)
#             td(total_fee)
#             td(total_external_cost)
#             td(total_net_amount)
#           end
#         end
 
# br
#           table_for weekly_hours.order(week_date: :desc) do
#           column('ID') { |wh| wh.id }
#           column('Date Range') { |wh| link_to(wh.date_range, admin_weekly_hour_path(wh)) }
#           column('Project Rate') { |wh| wh.project.rate }
#           column('Hours') { |wh| wh.hours }
#           column('Total Amount') { |wh| wh.total_amount }
#           column('Fee Percentage') { |wh| wh.project.fee_percentage }
#           column('Fee') { |wh| wh.fee }
#           column('External Rate') { |wh| wh.external_rate }
#           column('External Cost') { |wh| wh.external_cost }
#           column('Net Amount') { |wh| wh.net_amount }
#         end
#       end
#     else
#       panel 'Project not found'
#     end
#   end
# end



# app/admin/project_weekly_hours.rb
ActiveAdmin.register_page 'Project Weekly Hours' do
  menu false
     content title: 'Project logs' do
    project_id = params[:project_id]
     project = Project.find(project_id)
   
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

    total_weekly_hours_last_week = 0
    total_amount_last_week = 0
    total_fee_last_week = 0
    total_external_cost_last_week = 0
    total_net_amount_last_week = 0


    total_weekly_hours_current_year = 0
    total_amount_current_year = 0
    total_fee_current_year = 0
    total_external_cost_current_year = 0
    total_net_amount_current_year = 0


    project_weekly_hours = project.weekly_hours
      total_weekly_hours_all += project_weekly_hours.sum(:hours)
      total_amount_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_all += project_weekly_hours.sum { |weekly_hour| weekly_hour.net_amount }

      # Calculate totals for the current month
      project_weekly_hours_current_month = project_weekly_hours.where(week_date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      total_weekly_hours_current_month += project_weekly_hours_current_month.sum(:hours)
      total_amount_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_current_month += project_weekly_hours_current_month.sum { |weekly_hour| weekly_hour.net_amount }


    
      # Calculate totals for the current year
      project_weekly_hours_current_year = project_weekly_hours.where(date: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year)
      total_weekly_hours_current_year += project_weekly_hours_current_year.sum(:hours)
      total_amount_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount_current_year += project_weekly_hours_current_year.sum { |weekly_hour| weekly_hour.net_amount }
    
    


      # Calculate totals for the current week
project_weekly_hours_current_week = project_weekly_hours.where(week_date: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week)
total_weekly_hours_current_week += project_weekly_hours_current_week.sum(:hours)
total_amount_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.total_amount }
total_fee_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.fee }
total_external_cost_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.external_cost }
total_net_amount_current_week += project_weekly_hours_current_week.sum { |weekly_hour| weekly_hour.net_amount }
        # Calculate totals for the last week
project_weekly_hours_last_week = project_weekly_hours.where(week_date: 1.week.ago.beginning_of_week..1.week.ago.end_of_week)
total_weekly_hours_last_week += project_weekly_hours_last_week.sum(:hours)
total_amount_last_week += project_weekly_hours_last_week.sum { |weekly_hour| weekly_hour.total_amount }
total_fee_last_week += project_weekly_hours_last_week.sum { |weekly_hour| weekly_hour.fee }
total_external_cost_last_week += project_weekly_hours_last_week.sum { |weekly_hour| weekly_hour.external_cost }
total_net_amount_last_week += project_weekly_hours_last_week.sum { |weekly_hour| weekly_hour.net_amount }
  panel " Summary", class: 'custom-panel-heading' do
    columns do
     column do
       week_range = "#{Time.zone.now.beginning_of_week.strftime('%d')} to #{Time.zone.now.end_of_week(:saturday).strftime('%d')}"
  panel "Current Week #{Time.zone.now.beginning_of_week.strftime('%b')} #{week_range}", class: 'custom-panel-heading' do
       table do
        tr do
          th 'Hours'
          th 'Gross Amount'
          th 'Fee'
          th 'External cost' if total_external_cost_current_week.present?
          th 'Net Amount'
        end

        tr do
          td(total_weekly_hours_current_week)
          td(total_amount_current_week)
          td(total_fee_current_week)
          td(total_external_cost_current_week) if total_external_cost_current_week.present?
          td(total_net_amount_current_week)
        end
      end
     end
    end 
   
      column do
last_week_start = 1.week.ago.beginning_of_week
  last_week_end = 1.week.ago.end_of_week(:saturday)
  last_week_range = "#{last_week_start.strftime(' %d')} to #{last_week_end.strftime(' %d')}"
  panel "Last Week  #{last_week_start.strftime(' %b')}  #{last_week_range}", class: 'custom-panel-heading' do
       table do
        tr do
          th 'Hours'
          th 'Gross Amount'
          th 'Fee'
          th 'External Cost' if total_external_cost_last_week.present?
          th 'Net Amount'
        end

          tr do
            td(total_weekly_hours_last_week)
            td(total_amount_last_week)
            td(total_fee_last_week)
            td(total_external_cost_last_week)if total_external_cost_last_week.present?
            td(total_net_amount_last_week)
          end
      end
     end
    end  

   column do
    panel "Current Month #{Time.zone.now.beginning_of_week.strftime('%B')}", class: 'custom-panel-heading'  do
      table do
        tr do
         th 'Hours'
          th 'Gross Amount'
          th 'Fee'
          th 'External cost' if total_external_cost_current_month.present?
          th 'Net Amount'
        end

        tr do
          td(total_weekly_hours_current_month)
          td(total_amount_current_month)
          td(total_fee_current_month)
          td(total_external_cost_current_month) if total_external_cost_current_month.present?
          td(total_net_amount_current_month)
        end
      end
    end
 end



  column do
    panel " Current Year  #{Time.zone.now.beginning_of_week.strftime('%Y')}", class: 'custom-panel-heading' do
      table do
        tr do
          th 'Hours'
          th 'Gross Amount'
          th 'Fee'
          th 'External cost' if total_external_cost_current_year.present?
          th 'Net Amount'
        end

        tr do
          td(total_weekly_hours_current_year)
          td(total_amount_current_year)
          td(total_fee_current_year)
          td(total_external_cost_current_year) if total_external_cost_current_year.present?
          td(total_net_amount_current_year)
        end
      end
    end
  end
  end 
  end
    
 
end
end
