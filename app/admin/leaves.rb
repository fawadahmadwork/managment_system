ActiveAdmin.register Leave do
  menu false
  before_action :skip_sidebar!, only: :index
  actions :all, except: %i[destroy ]
  config.remove_action_item(:new)
  action_item :remaining_leave_info, only: [:new] do
    employee = Employee.find(params[:employee_id])
   div do
        "Remaining Paid Sick Leaves: #{employee.sick_leaves_limit - employee.sick_leaves_taken}"
      end
    div do
      "Remaining Paid Urgent Work Leaves: #{employee.urgent_leaves_limit - employee.urgent_leaves_taken}"
    end
  end

  action_item :back_to_employee, only: :show do
    link_to 'Back to Employee', admin_employee_path(resource.employee)
  end
  
  form id: 'leave-form' do |f|
    f.semantic_errors if f.object.errors.any?

    f.inputs 'Leaves Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
      end
   
        f.input :leave_type, as: :select, collection: %w[Sick Urgent_Work Extra Hajj Marriage ], include_blank: false



      f.input :category, as: :select, collection: %w[Paid Unpaid],
      include_blank: false






        f.input :duration, as: :select, collection: %w[One_Day Long_Leave], include_blank: false

                 





f.input :duration_type, as: :hidden, input_html: { value: 'Full_Day' }
  div class: 'inline-container' do
    f.label 'Duration Type', class: 'inline-label'
    f.input :half_day, as: :boolean, wrapper_html: { class: 'inline-days'}
  end








        f.input :start_date, as: :datepicker, input_html: {style: 'width: 200px;' }




        f.input :end_date, as: :datepicker, input_html: { style: 'width: 200px;'}



     
        f.input :leave_days,  input_html: { readonly: true, value: 1,  style: 'width: 200px;' }
      if f.object.new_record?
        f.input :status, as: :select, collection: ['Pending', 'Approved', 'Canceled'],
            input_html: { hidden: true }, wrapper_html: { style: 'display:none;' }, selected: 'Approved'
      else
        f.input :status, as: :select, collection: ['Pending', 'Approved', 'Canceled']
      end
      
   end

    f.actions
  end

  index do
    selectable_column
    column :leave_type
    column :category
    column :duration
    column :duration_type
    column :status
    column :leave_days
    actions
  end

  show do
    attributes_table do
      row :leave_type
      row :category 
      row :duration
      row :duration_type
      row :leave_days
      row :start_date 
      row :end_date
      row :status
    end
  end
  # controller do
  #   # ...

  #   def create
  #     super do |format|
  #       LeaveMailer.admin_notification(resource).deliver_now
  #     end
  #   end

  #   def update
  #     super do |format|
  #       LeaveMailer.employee_notification(resource).deliver_now
  #     end
  #   end
  # end
  #     
  #   
  permit_params :leave_type, :category, :duration, :duration_type, :start_date, :end_date, :total_days, :status, :employee_id, :leave_days, :half_day
end
