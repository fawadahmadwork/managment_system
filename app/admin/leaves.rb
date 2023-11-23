ActiveAdmin.register Leave do
  menu false
  before_action :skip_sidebar!, only: :index
  actions :all, except: %i[destroy ]
  config.remove_action_item(:new)
  action_item :back_to_employee, only: :show do
    link_to 'Back to Employee', admin_employee_path(resource.employee)
  end
  form id: 'leave-form' do |f|
    f.semantic_errors(*f.object.errors.keys) if f.object.errors.any?

    f.inputs 'Leaves Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
      end
      if object.new_record?
        f.input :Remaining_sick_leaves, input_html: { readonly: true, value: 10 - employee.leaves.where(status: 'Approved', leave_type: 'Sick').sum(:total_days) }
        f.input :Remaining_Urgent_Work_leaves, input_html: { readonly: true, value: 5 - employee.leaves.where(status: 'Approved', leave_type: 'Urgent_Work').sum(:total_days) }
      end
        f.input :leave_type, as: :select, collection: %w[Sick Urgent_Work Extra Hajj Marriage ],
                       include_blank: false
        f.input :category, as: :select, collection: %w[ Paid Unpaid ],
                       include_blank: false
        f.input :duration,  as: :select, collection: %w[One_Day Multiple_Days ],
                       include_blank: false, input_html: { id: 'leave_duration' }
        f.input :duration_type, as: :select, collection: %w[Full_Day Half_Day ],
                       include_blank: false, input_html: { id: 'leave_duration_type' }
        f.input :start_date,  as: :datepicker, label: 'Select Date'
        f.input :end_date, as: :datepicker, wrapper_html: { style: 'display:none;' }, input_html: { style: 'display:none;', id: 'leave_end_date_input' }
      if f.object.new_record?
        f.input :total_days, label: 'leave_days',      input_html: { value: 1, id: 'leave_total_days' }
      else
        f.input :total_days, input_html: {id: 'leave_total_days' }
      end
      if f.object.new_record?
        f.input :status, as: :select, collection: ['Pending', 'Approved', 'Canceled'],
            input_html: { hidden: true }, wrapper_html: { style: 'display:none;' }, selected: 'Pending'
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
    column :total_days
    actions
  end

  show do
    attributes_table do
      row :leave_type
      row :category 
      row :duration
      row :duration_type
      row :total_days
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
  

  permit_params :leave_type, :category, :duration, :duration_type, :start_date, :end_date, :total_days, :status, :employee_id
end
