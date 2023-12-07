# ActiveAdmin.register_page 'Project weekly hours' do

# menu false

#     content title: 'Project weekly hours' do
#     project_id = params[:project_id]
#     project = Project.find(project_id)
#     weekly_hours = project.weekly_hours
#     total_weekly_hours = weekly_hours.sum(:hours)
#     monthly_weekly_hours = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum(:hours)

#  panel '' ,
#           style: 'font-size: 15px; font-weight: bold;' do
#       table do
#         tr do
#           th 'Project total hours'
#         end

#         tr do
#           td( total_weekly_hours)
#         end
#       end
#         tr do
#           th 'current month hours'
#         end

#         tr do
#           td( monthly_weekly_hours)
#         end
#     end

# end
# end
# 
#
#
#




# ActiveAdmin.register_page 'Project weekly hours' do
#   menu false

#   content title: 'Project weekly hours' do
#     project_id = params[:project_id]
#     project = Project.find(project_id)

#     if project
#       weekly_hours = project.weekly_hours
#       total_weekly_hours = weekly_hours.sum(:hours)
#       total_amount = weekly_hours.sum { |weekly_hour| weekly_hour.total_amount }
#       total_fee = weekly_hours.sum { |weekly_hour| weekly_hour.fee }
#       total_external_cost = weekly_hours.sum { |weekly_hour| weekly_hour.external_cost }
#       total_net_amount = weekly_hours.sum { |weekly_hour| weekly_hour.net_amount }
     
     
#       monthly_weekly_hours = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum(:hours)

#     panel 'Project logs', style: 'font-size: 15px; font-weight: bold;' do
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
#             td(total_external_cost )
#             td(total_net_amount )
#           end

#           tr do
#             th 'Current month hours'
#           end

#           tr do
#             td(monthly_weekly_hours)
#           end
#         end
#       end
#       panel 'All Weekly Hours Entries' do
#   table_for weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).order(created_at: :desc) do
#     column('ID') { |wh| wh.id }
#     column('Hours') { |wh| wh.hours }
#     column('External Rate') { |wh| wh.external_rate }
#     column('Created At') { |wh| wh.created_at }
#     # Add more columns as needed

#     # You can customize the table with additional columns based on your WeeklyHour model attributes
#   end
# end

#       panel 'All Weekly Hours Entries' do
#         table_for weekly_hours.order(created_at: :desc) do
#           column('ID') { |wh| wh.id }
#           column('Hours') { |wh| wh.hours }
#           column('External Rate') { |wh| wh.external_rate }
#           column('Created At') { |wh| wh.created_at }
#           # Add more columns as needed

#           # You can customize the table with additional columns based on your WeeklyHour model attributes
#         end
#       end
#     else
#       panel 'Project not found'
#     end
#   end
# end
# 
#





ActiveAdmin.register_page 'Project weekly hours' do
  menu false

  content title: 'Project weekly hours' do
    project_id = params[:project_id]
    project = Project.find(project_id)

    if project
      weekly_hours = project.weekly_hours
      this_month_weekly_hours = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      total_weekly_hours = weekly_hours.sum(:hours)
      total_amount = weekly_hours.sum { |weekly_hour| weekly_hour.total_amount }
      total_fee = weekly_hours.sum { |weekly_hour| weekly_hour.fee }
      total_external_cost = weekly_hours.sum { |weekly_hour| weekly_hour.external_cost }
      total_net_amount = weekly_hours.sum { |weekly_hour| weekly_hour.net_amount }
     
      monthly_weekly_hours = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum(:hours)
      monthly_total_amount = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.total_amount }
      monthly_total_fee = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.fee }
      monthly_total_external_cost = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.external_cost }
      monthly_total_net_amount = weekly_hours.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).sum { |weekly_hour| weekly_hour.net_amount }

     panel 'Project Total logs', style: 'font-size: 13px;' do
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
      end

      panel 'Monthly Logs', style: 'font-size: 13px;' do
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
      end

      # panel 'All Weekly Hours Entries' do
      #   table_for weekly_hours.order(created_at: :desc) do
      #     column('ID') { |wh| wh.id }
      #     column('Hours') { |wh| wh.hours }
      #     column('External Rate') { |wh| wh.external_rate }
      #     column('Created At') { |wh| wh.created_at }
      #     # Add more columns as needed

      #     # You can customize the table with additional columns based on your WeeklyHour model attributes
      #   end
      # end
      # 
         panel 'All Weekly Hours Entries for This Month' do
        table_for this_month_weekly_hours.order(created_at: :desc) do
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



        panel 'Total Hours Entries' do
        table_for weekly_hours.order(created_at: :desc) do
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

