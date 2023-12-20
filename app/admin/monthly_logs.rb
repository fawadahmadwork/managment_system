ActiveAdmin.register_page 'Monthly Logs' do
  content title: ' Project Logs' do
  

   def selected_month
    params[:q].try(:[], :date_month_eq) || Time.zone.now.month
  end

  # Helper method to get the selected year from params or default to the current year
  def selected_year
    params[:q].try(:[], :date_year_eq) || Time.zone.now.year
  end

  # Helper method to get the date range for the selected month and year
  def selected_month_and_year_range
  start_date = Time.zone.local(selected_year, selected_month)
  start_date..start_date.end_of_month
end









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

    
    end
  columns do
     panel 'Last Week Total logs', class: 'custom-panel-heading' do
       table do
        tr do
          th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        tr do
          td(total_weekly_hours_last_week)
          td(total_amount_last_week)
          td(total_fee_last_week)
          td(total_external_cost_last_week)
          td(total_net_amount_last_week)
        end
      end
     end
    end 
 
columns do
   column do
     panel 'Current Week Total logs', class: 'custom-panel-heading' do
       table do
        tr do
          th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        tr do
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
    panel 'Current Month Total logs', class: 'custom-panel-heading'  do
      table do
        tr do
         th 'Total hours'
          th 'Gross Amount'
          th 'Fee paid'
          th 'External cost'
          th 'Net Amount'
        end

        tr do
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
    panel ' Current Year logs', class: 'custom-panel-heading' do
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


  render 'admin/shared/monthly_logs_filter', context: self

    
  panel "Projects Monthly Logs ( #{selected_month_and_year_range.begin.strftime('%B')} )", class: 'custom-panel-heading' do  
    
    table do
      tr do
        th 'Project Name'
        th 'Project logs'
        th 'Total hours'
        th 'Gross Amount'
        th 'Fee paid'
        th 'External cost'
        th 'Net Amount'
      end
      
      total_weekly_hours = 0
      total_amount = 0
      total_fee = 0
      total_external_cost = 0
      total_net_amount = 0
      
      Project.all.each do |project|
        selected_month_and_year = Date.new(selected_year.to_i, selected_month.to_i)
        
        project_weekly_hours_selected_month = project.weekly_hours.where(week_date: selected_month_and_year.beginning_of_month..selected_month_and_year.end_of_month)
        total_weekly_hours += project_weekly_hours_selected_month.sum(:hours)
        total_amount += project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.total_amount }
        total_fee += project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.fee }
        total_external_cost += project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.external_cost }
        total_net_amount += project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.net_amount }
        
        tr do
          td { link_to project.name, admin_project_path(project) }
          td { link_to "View details", admin_project_weekly_hours_path(project_id: project.id) }
          td project_weekly_hours_selected_month.sum(:hours)
          td project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.total_amount }
          td project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.fee }
          td project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.external_cost }
          td project_weekly_hours_selected_month.sum { |weekly_hour| weekly_hour.net_amount }
        end
      end
      
      # Display the total row
      tr do
        th 'Total'
        th '' # Placeholder for 'View Logs'
        th total_weekly_hours
        th total_amount
        th total_fee
        th total_external_cost
        th total_net_amount
      end
    end
  end


  #   panel 'Current Month  Weekly Hours entries', class: 'custom-panel-heading' do
    
  #   table_for WeeklyHour.all.where(week_date: selected_month_and_year_range).order(week_date: :desc) do
      
  #     column 'Project' do |weekly_hour|
  #       link_to weekly_hour.project.name, admin_project_path(weekly_hour.project)
  #     end
  #   column 'Week Date Range', :date_range
  #   column 'Hours', :hours
  #   column 'Total Amount', :total_amount
  #   column 'Fee Paid', :fee
  #   column 'External Cost', :external_cost
  #   column 'Net Amount', :net_amount
    
  #  end
  #  end



(1..5).reverse_each do |week_number|
  start_of_month = selected_month_and_year_range.begin
  end_of_month = selected_month_and_year_range.end

  week_start_date = start_of_month + (week_number - 1).weeks
  week_end_date = start_of_month + week_number.weeks - 1.day

  week_entries = WeeklyHour.where(week_date: week_start_date..week_end_date)
                           .where("EXTRACT(MONTH FROM week_date) = ? AND EXTRACT(YEAR FROM week_date) = ?", selected_month, selected_year)
                           .order(:project_id)

  next if week_entries.empty?

  # total_hours_week = week_entries.sum(:hours)
total_hours_week = week_entries.sum(:hours)
  total_gross_amount_week = week_entries.sum { |weekly_hour| weekly_hour.total_amount }
  total_fee_week = week_entries.sum { |weekly_hour| weekly_hour.fee }
  total_external_cost_week = week_entries.sum { |weekly_hour| weekly_hour.external_cost }
  total_net_amount_week = week_entries.sum { |weekly_hour| weekly_hour.net_amount }
  panel " #{week_number.ordinalize} Week of #{start_of_month.strftime('%B')}", class: 'custom-panel-heading'do
    table_for week_entries do
      column 'Project' do |weekly_hour|
        weekly_hour.project.name
      end
      column 'Week Date Range' do |weekly_hour|
        weekly_hour.date_range
      end
      column 'Hours' do |weekly_hour|
        weekly_hour.hours
      end
      column 'Gross Amount' do |weekly_hour|
        weekly_hour.total_amount
      end
      column 'Fee Paid' do |weekly_hour|
        weekly_hour.fee
      end
      column 'External Cost' do |weekly_hour|
        weekly_hour.external_cost
      end
      column 'Net Amount' do |weekly_hour|
        weekly_hour.net_amount
      end
        end
  panel "Total " do
      table do
       tr do
         th '  Total Hours'
         th 'Gross Amount'
         th 'Fee paid'
         th 'External cost'
         th 'Net Amount'
       end
       tr do
        th total_hours_week
        th total_gross_amount_week
        th total_fee_week
        th total_external_cost_week
        th total_net_amount_week
       end
      end
      end
  
  
end
end











end
end





